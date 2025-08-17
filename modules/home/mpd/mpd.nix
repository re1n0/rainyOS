{ os, ... }:
{
  services.mpd = {
    enable = true;
  };
  services.mpd-mpris.enable = os.mpd.mpris;
}
