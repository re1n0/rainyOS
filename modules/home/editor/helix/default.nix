{
  pkgs,
  config,
  ...
}:
let
  languages = import ./languages.nix;
  settings = import ./settings.nix;
  themes = import ./themes.nix config;
in
{
  home.packages = with pkgs; [
    deadnix
    nixd
    nixfmt-tree
    statix

    tombi

    yaml-language-server

    markdown-oxide

    superhtml
    jinja-lsp

    lldb
    rust-analyzer

    bash-language-server
    shfmt

    lua-language-server

    kotlin-language-server
    ktfmt
  ];

  programs.helix = {
    enable = true;
    defaultEditor = true;

    inherit languages settings themes;
  };

  stylix.targets.helix.enable = false;
}
