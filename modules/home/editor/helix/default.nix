{
  pkgs,
  config,
  os,
  lib,
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
    nil
    nixfmt-tree
    nixfmt-rfc-style
    statix

    tombi

    yaml-language-server

    markdown-oxide

    superhtml
    jinja-lsp

    lldb
    rust-analyzer

    bash-language-server

    lua-language-server
  ];

  programs.helix = {
    enable = true;
    defaultEditor = true;

    inherit languages settings themes;
  };

  stylix.targets.helix.enable = false;
}
