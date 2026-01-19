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
      runtimeInputs = [ pass ];
      text = # shell
        ''
          pass "$@"
        '';
    })
  ];
}
