let
  modules = import ./modules.nix;
in
{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "auto";
        padding.top = 1;
      };

      display.separator = " ";

      inherit modules;
    };
  };
}
