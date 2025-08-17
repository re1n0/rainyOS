{ lib, ... }:
{
  options.myHome = {
    username = lib.mkOption {
      type = lib.types.str;
      default = "joe";
      description = "Username";
    };
  };
}
