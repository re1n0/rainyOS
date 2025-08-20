{ pkgs, os, ... }:
let
  cfg = os.git;
in
{
  programs.git = {
    enable = true;

    userName = "${cfg.username}";
    userEmail = "${cfg.email}";

    package = pkgs.gitFull;

    delta.enable = true;

    signing = {
      format = "openpgp";
      key = "${cfg.signingKey}";
      signByDefault = cfg.signingKey != "";
    };

    extraConfig.credential = {
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
}
