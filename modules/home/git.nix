{ pkgs, os, ... }:
let
  cfg = os.git;
in
{
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
      helper = "gopass";
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

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

  home.packages = with pkgs; [
    git-credential-gopass
  ];

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}
