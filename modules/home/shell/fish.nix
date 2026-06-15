{ pkgs, ... }:
let
  shellAbbrs = import ./abbrs.nix;
  shellAliases = import ./aliases.nix;
in
{
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

      set -Ux fifc_editor hx
      set -U fifc_bat_opts --style=numbers
      set -U fifc_fd_opts --hidden
      set -U fifc_eza_opts --icons --tree

      set -Ux FZF_DEFAULT_OPTS "--bind=tab:down,shift-tab:up,ctrl-space:toggle"
    '';

    plugins =
      with pkgs.fishPlugins;
      map
        (pkg: {
          name = pkg.pname;
          inherit (pkg) src;
        })
        [
          puffer
          fzf-tab
          git-abbr
          plugin-sudope
          spark
        ];
  };
}
