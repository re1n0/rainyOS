{
  lib,
  graalvmPackages,
  fetchurl,
}:
let
  archive = {
    "x86_64-linux" = {
      hash = "sha256-Z6yFh2tEAs4lO7zoXevRrFFcZQUw7w7Stkx9dUB46CE=";
      url = "https://download.oracle.com/graalvm/21/archive/graalvm-jdk-21.0.7_linux-x64_bin.tar.gz";
    };
  };
in
graalvmPackages.buildGraalvm {
  src = fetchurl archive."x86_64-linux";

  pname = "graalvm-oracle";
  version = "21";

  useMusl = false;
  meta = {
    platforms = builtins.attrNames archive;
    license = lib.licenses.unfree;
  };
}
