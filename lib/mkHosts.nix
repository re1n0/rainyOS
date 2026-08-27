{inputs}: let
  mkHost = import ./mkHost.nix {inherit inputs;};
in
  hostsDir: hosts: let
    defaultsFile = hostsDir + "/defaults.toml";
    defaults =
      inputs.nixpkgs.lib.optionalAttrs (builtins.pathExists defaultsFile)
      (fromTOML (builtins.readFile defaultsFile));
  in
    inputs.nixpkgs.lib.mapAttrs
    (hostname: cfg:
      mkHost (cfg
        // {
          inherit hostname defaults;
          path = hostsDir + "/${hostname}";
        }))
    hosts
