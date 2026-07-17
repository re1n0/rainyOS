{
  symlinkJoin,
  freecad,
  makeWrapper,
  mesa,
}:
symlinkJoin {
  name = "freecad-fix";
  paths = [
    freecad
  ];
  buildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/FreeCAD \
      --prefix __GLX_VENDOR_LIBRARY_NAME : mesa \
      --prefix __EGL_VENDOR_LIBRARY_FILENAMES : ${mesa}/share/glvnd/egl_vendor.d/50_mesa.json \
      --prefix MESA_LOADER_DRIVER_OVERRIDE : zink \
      --prefix GALLIUM_DRIVER : zink \
      --prefix LIBGL_KOPPER_DRI2 : 1 \
  '';
}
