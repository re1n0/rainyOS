{mkTarget, ...}:
mkTarget "bluez" {
  tags = ["bluetooth"];
  description = "Linux Bluetooth protocol stack";

  nixos = _: {
    hardware.bluetooth = {
      enable = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
          FastConnectable = true;
        };
      };
    };
  };
}
