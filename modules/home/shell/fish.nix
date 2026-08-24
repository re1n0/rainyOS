{pkgs, ...}: let
  shellAbbrs = import ./abbrs.nix;
  shellAliases = import ./aliases.nix;
in {
  imports = [
    ./cli.nix
  ];

  home.packages = with pkgs; [
    babelfish
  ];

  programs.fish = {
    enable = true;

    inherit shellAbbrs shellAliases;

    interactiveShellInit = ''
      set -g fish_greeting "" # Disable greeting

      set -Ux fifc_editor v
      set -U fifc_fd_opts --hidden

      set -Ux FZF_DEFAULT_OPTS "--bind=tab:down,shift-tab:up,ctrl-space:toggle"
    '';

    plugins = with pkgs.fishPlugins;
      map
      (pkg: {
        name = pkg.pname;
        inherit (pkg) src;
      })
      [
        puffer
        fifc
        git-abbr
        plugin-sudope
        spark
      ];
  };
}
