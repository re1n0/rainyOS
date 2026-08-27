{
  lib,
  linux-cachyos-bore-lto-x86_64-v3,
}: let
  base = linux-cachyos-bore-lto-x86_64-v3;
in
  base.override {
    pname = "${lib.versions.pad 3 base.version}-rainy";

    structuredExtraConfig.LOCALVERSION = lib.mkForce (lib.kernel.freeform "-rainyos");

    lto = "thin";
    processorOpt = "x86_64-v3";

    cpusched = "bore";
    hzTicks = "1000";
    tickrate = "full";
    preemptType = "full";
    hugepage = "madvise";
    bbr3 = true;
  }
