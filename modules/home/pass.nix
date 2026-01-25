{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    gopass
    gopass-hibp
    (writeShellApplication {
      name = "pass";
      runtimeInputs = [ gopass ];
      text = # shell
        ''
          gopass "$@"
        '';
    })
  ];
}
