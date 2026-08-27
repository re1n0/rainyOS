{mkTarget, ...}:
mkTarget "pass" {
  tags = ["tui"];
  description = "Standard unix password manager";

  nixos = {pkgs, ...}: {
    system.replaceDependencies.replacements = [
      {
        oldDependency = pkgs.pass;
        replacement = pkgs.symlinkJoin {
          pname = "password-store";
          version = pkgs.pass.version;
          paths = let
            gopass-pass = pkgs.writeShellApplication {
              name = "pass";
              runtimeInputs = [pkgs.gopass];
              text = ''
                exec gopass "$@"
              '';
            };
          in [
            gopass-pass
          ];
        };
      }
    ];
  };

  hm = {
    config,
    pkgs,
    ...
  }: {
    home.packages = with pkgs; [
      pass
      pass-tui
    ];

    programs.gopass.enable = true;

    home.sessionVariables.PASSWORD_STORE_DIR = config.xdg.dataHome + "/password-store";

    persist.files = [
      ".local/share/password-store"
    ];

    programs.yazi.plugins.gvfs.settings.password_vault = "pass";
    programs.git.settings.credential.credentialStore = "gpg";
  };
}
