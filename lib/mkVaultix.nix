{inputs}: {
  nixosConfigurations,
  identity,
  extraRecipients ? [],
  cache ? "./secrets/cache",
}:
inputs.vaultix.configure {
  nodes = nixosConfigurations;
  inherit identity extraRecipients cache;
}
