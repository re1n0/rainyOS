{mkTarget, ...}:
mkTarget "git" {
  tags = ["development"];
  description = "Git version control system";

  hm = {
    lib,
    pkgs,
    ...
  }: {
    programs.git = {
      enable = true;

      signing.signByDefault = true;

      settings = {
        credential = {
          helper = lib.getExe pkgs.git-credential-manager;
          credentialStore = lib.mkDefault "cache";
        };
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
  };
}
