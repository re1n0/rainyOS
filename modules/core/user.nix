{
  pkgs,
  inputs,
  host,
  config,
  ...
}:
let
  os = config.rainyos;
  userGroups = [
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
    extraGroups = userGroups;
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    openssh.authorizedKeys.keys = os.ssh.authorizedKeys;
  };

  homeSettings = username: {
    imports = [
      ./../home
      ./../home/${username}
    ];

    home = {
      username = "${username}";
      homeDirectory = "/home/${username}";
      stateVersion = "25.11";
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

    users = {
      work = homeSettings "work";
      priv = homeSettings "priv";
    };
  };

  users.users = {
    work = userSettings;
    priv = userSettings;
  };

  nix.settings.allowed-users = [
    "priv"
    "work"
  ];
}
