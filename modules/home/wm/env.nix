{ config, lib, ... }:
{
  home.sessionVariables = {
    SDL_VIDEODRIVER = "wayland";

    QT_QPA_PLATFORM = "wayland;xcb";
    QT_AUTO_SCREEN_SCALE_FACTOR = 1;
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
  }
  // lib.optionalAttrs config.hardware.nvidia.enabled {
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    __GL_GSYNC_ALLOWED = 1;
    __GL_VRR_ALLOWED = 0;
  };
}
