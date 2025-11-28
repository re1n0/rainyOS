{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.rainyos.audio.enable {
  services.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;

    lowLatency = {
      enable = true;
      quantum = 256;
      rate = 48000;
    };
  };

  environment.systemPackages = with pkgs; [
    rtaudio
  ];

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

  security.pam.loginLimits = [
    {
      domain = "@audio";
      item = "memlock";
      type = "-";
      value = "unlimited";
    }
    {
      domain = "@audio";
      item = "rtprio";
      type = "-";
      value = "99";
    }
  ];
}
