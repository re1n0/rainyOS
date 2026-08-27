{inputs, ...}: {
  flake.nixosModules.bindings = _: (
    inputs.import-tree [
      ./_bindings
    ]
  );
}
