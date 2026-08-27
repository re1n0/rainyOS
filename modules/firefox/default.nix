{
  lib,
  mkTarget,
  ...
}: let
  mkFirefoxTarget = import ./_lib/mkFirefoxTarget.nix {inherit mkTarget;};
in {
  config = lib.mkMerge [
    (mkFirefoxTarget "glide-browser" "Keyboard-focused web browser")
  ];
}
