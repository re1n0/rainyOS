{ pkgs, ... }:
let
  shellAbbrs = import ./abbrs.nix;
  shellAliases = import ./aliases.nix;
in
{
  imports = [
    ./cli.nix
  ];

  programs.fish = {
    enable = true;

    inherit shellAbbrs shellAliases;

    interactiveShellInit = ''
      set -g fish_greeting "" # Disable greeting

      set -Ux fifc_editor hx
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
