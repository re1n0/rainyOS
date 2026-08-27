_: {
  flake.nixosModules.fwupd = _: {
    services.fwupd.enable = true;
  };
}
