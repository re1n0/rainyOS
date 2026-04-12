{ config, lib, ... }:
{
  home.sessionVariables = {
    SDL_VIDEODRIVER = "wayland";

    QT_QPA_PLATFORM = "wayland;xcb";
    QT_AUTO_SCREEN_SCALE_FACTOR = 1;
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
    QT_QPA_PLATFORMTHEME = "xdgdesktopportal";

    GTK_USE_PORTAL = 1;

    GDK_BACKEND = "wayland,x11,*";

    CLUTTER_BACKEND = "wayland";

    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  }
  // lib.optionalAttrs config.hardware.nvidia.enabled {
    NVD_BACKEND = "direct";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    __GL_GSYNC_ALLOWED = 1;
    __GL_VRR_ALLOWED = 1;
  };
}
