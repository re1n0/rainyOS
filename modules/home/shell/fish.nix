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

      set -Ux FZF_DEFAULT_OPTS "--bind=tab:down,shift-tab:up,ctrl-space:toggle"

      fifc \
        -n 'test -f "$fifc_candidate"; and string match -rq "^(image|video)/" (file --mime-type -b -- "$fifc_candidate")' \
        -p 'mcat "$fifc_candidate"' \
        -o 'mcat "$fifc_candidate"' \
        -O 1
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
