_:
let
  shellAliases = import ../shell/aliases.nix;
in
{
  imports = [
    ../shell/bat.nix
    ../shell/fzf.nix
    ../shell/less.nix
    ../shell/man.nix
    ../shell/ripgrep.nix
    ../shell/zoxide.nix
    ../shell/cli.nix
  ];

  programs.zsh = {
    enable = true;

    autocd = true;
    enableCompletion = true;

    inherit shellAliases;
  };
}
