_:
let
  shellAliases = import ../aliases.nix;
  zplug = import ./zplug.nix;
in
{
  imports = [
    ../cli.nix
  ];

  programs.zsh = {
    enable = true;

    autocd = true;
    enableCompletion = true;

    inherit zplug shellAliases;
  };
}
