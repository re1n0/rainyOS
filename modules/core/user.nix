{ pkgs
, inputs
, host
, config
, ...
}:
let
  os = config.rainyos;
  extraGroups = [
    "adbusers"
    "audio"
    "docker"
    "gamemode"
    "input"
    "libvirtd"
    "networkmanager"
    "rtkit"
    "wheel"
  ];

  userSettings = {
    isNormalUser = true;
    description = os.git.username;
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    openssh.authorizedKeys.keys = os.ssh.authorizedKeys;
    inherit extraGroups;
  };

  homeSettings = username: {
    imports = [
      ./../home
      ./../home/${username}
    ];

    home = {
      homeDirectory = "/home/${username}";
      stateVersion = "25.11";
      inherit username;
    };

    programs.home-manager.enable = true;
  };
in
{
  users.mutableUsers = true;

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "bak";
    extraSpecialArgs = {
      inherit
        inputs
        host
        os
        ;
    };

    users =
      if os.configuration == "desktop" then
        {
          work = homeSettings "work";
          priv = homeSettings "priv";
        }
      else
        (
          if os.configuration == "iso" then
            {
              nixos =
                let
                  username = "nixos";
                in
                {
                  imports = [
                    ./../home/iso
                  ];

                  home = {
                    homeDirectory = "/home/${username}";
                    stateVersion = "25.11";
                    inherit username;
                  };

                  programs.home-manager.enable = true;
                };
            }
          else
            { }
        );
  };

  users.users =
    if os.configuration == "desktop" then
      {
        work = userSettings;
        priv = userSettings;
      }
    else
      (
        if os.configuration == "iso" then
          {
            nixos = {
              isNormalUser = true;
              shell = pkgs.zsh;
              ignoreShellProgramCheck = true;
              openssh.authorizedKeys.keys = os.ssh.authorizedKeys;
              extraGroups = [
                "adbusers"
                "input"
                "networkmanager"
                "rtkit"
                "wheel"
              ];
            };
          }
        else
          { }
      );

  nix.settings.allowed-users = [
    "priv"
    "work"
  ];
}
