{
  lib,
  linux-cachyos-latest,
}: let
  base = linux-cachyos-latest;
in
  base.override {
    pname = "linux-cachyos-rainy";

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
