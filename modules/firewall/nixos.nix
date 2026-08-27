_: {
  flake.nixosModules.firewall = {
    config,
    lib,
    ...
  }: {
    options.firewall = {
      reversePathFilterRules = lib.mkOption {
        type = lib.types.listOf lib.types.lines;
        default = [];
      };
      inputRules = lib.mkOption {
        type = lib.types.listOf lib.types.lines;
        default = [];
      };
      forwardRules = lib.mkOption {
        type = lib.types.listOf lib.types.lines;
        default = [];
      };
    };

    config = {
      networking.nftables.enable = true;

      networking.firewall.enable = true;

      networking.firewall.extraReversePathFilterRules =
        lib.concatStringsSep "\n" config.firewall.reversePathFilterRules;

      networking.firewall.extraInputRules =
        lib.concatStringsSep "\n" config.firewall.inputRules;

      networking.firewall.extraForwardRules =
        lib.concatStringsSep "\n" config.firewall.forwardRules;
    };
  };
}
