{
  lib,
  pkgs,
  os,
  ...
}: let
  cfg = os.git;
in {
  programs.git = {
    enable = true;

    package = pkgs.gitFull;

    signing = {
      format = "openpgp";
      key = "${cfg.signingKey}";
      signByDefault = cfg.signingKey != "";
    };

    settings.user = {
      name = "${cfg.username}";
      email = "${cfg.email}";
    };

    settings.credential = {
      helper = lib.getExe pkgs.git-credential-manager;
      credentialStore = "gpg";
      color = {
        diff = "auto";
        status = "auto";
        branch = "auto";
        interactive = "auto";
        ui = "auto";
        pager = true;
      };
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}
