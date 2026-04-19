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
    '';

    plugins =
      with pkgs.fishPlugins;
      map
        (pkg: {
          name = pkg.pname;
          inherit (pkg) src;
        })
        [
          bang-bang
          fzf-fish
          git-abbr
          plugin-sudope
          puffer
          spark
        ];
  };
}
