{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    gopass
    gopass-hibp
  ];
}
