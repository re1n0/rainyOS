{mkTarget, ...}:
mkTarget "pipewire-bluetooth" {
  tags = ["audio" "bluetooth"];
  description = "BlueZ config for Wireplumber";

  nixos = _: {
    services.pipewire.wireplumber.extraConfig."10-bluez" = {
      "monitor.bluez.properties" = {
        "bluez5.enable-sbc-xq" = true;
        bluez5.a2dp.ldac.quality = "sq";
        "bluez5.enable-hw-volume" = true;
        "bluez5.roles" = [
          "a2dp_sink"
          "a2dp_source"
          "hsp_hs"
          "hsp_ag"
          "hfp_hf"
          "hfp_ag"
          "bap_sink"
          "bap_source"
        ];
        "bluez5.codecs" = [
          "lhdc_v5"
          "aptx_hd"
          "ldac"
          "aptx_ll"
          "aptx"
          "sbc_xq"
          "aac"
          "lc3"
          "sbc"
        ];
      };
    };
  };
}
