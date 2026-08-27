{inputs}: {
  hostname,
  system,
  path,
  defaults ? {},
}: let
  inherit (inputs) self nixpkgs;
  inherit (nixpkgs) lib;

  profiles = import ../profiles;

  settingsFile = path + "/settings.toml";
  secretsDir = path + "/secrets";

  hostToml =
    lib.recursiveUpdate defaults
    (lib.optionalAttrs (builtins.pathExists settingsFile)
      (fromTOML (builtins.readFile settingsFile)));

  baseMeta =
    if hostToml ? profile
    then profiles.${hostToml.profile}
    else [];
  tomlSpecializations = hostToml.specializations or {};
  settings = removeAttrs hostToml ["meta" "profile" "target" "specializations"];
  settingsModule = lib.optionalAttrs (settings != {}) {rainy.settings = settings;};

  mkMeta = m: {
    rainy.meta = {
      enable = baseMeta ++ (m.enable or []);
      disable = m.disable or [];
    };
  };

  mkModuleFor = cfg:
    (mkMeta (cfg.meta or {}))
    // lib.optionalAttrs (cfg ? target) {rainy.target = cfg.target;};

  secretFiles =
    if builtins.pathExists secretsDir
    then lib.filterAttrs (n: t: t == "regular" && lib.hasSuffix ".age" n) (builtins.readDir secretsDir)
    else {};
  vaultixSecrets =
    lib.mapAttrs'
    (file: _:
      lib.nameValuePair
      (lib.removeSuffix ".age" file)
      {file = secretsDir + "/${file}";})
    secretFiles;
in
  nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = {inherit inputs;};
    modules =
      [
        {imports = lib.attrValues self.nixosModules;}
        {nixpkgs.overlays = [self.overlays.default];}
        {
          home-manager = {
            extraSpecialArgs = {inherit inputs;};
            useUserPackages = true;
            useGlobalPkgs = true;
          };
          home-manager.sharedModules =
            [{imports = lib.attrValues self.homeManagerModules;}]
            ++ lib.optional (builtins.pathExists (path + "/apps.nix")) (path + "/apps.nix")
            ++ lib.optional (builtins.pathExists (path + "/home-overrides.nix")) (path + "/home-overrides.nix");
        }
        {networking.hostName = hostname;}
        (mkModuleFor hostToml)
        settingsModule
        {vaultix.secrets = vaultixSecrets;}
      ]
      ++ lib.optional (builtins.pathExists (path + /overrides.nix)) (path + /overrides.nix)
      ++ lib.mapAttrsToList
      (name: cfg: {specialisation.${name}.configuration = mkModuleFor cfg;})
      tomlSpecializations;
  }
