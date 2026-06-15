{
  lib,
  stdenv,
  fd,
  fzf,
  buildFishPlugin,
  rainySources,
  fishPlugins,
}:
buildFishPlugin {
  inherit (rainySources."fzf-tab")
    pname
    version
    src
    date
    ;

  nativeCheckInputs = [
    fzf
    fd
  ];

  checkPlugins = with fishPlugins; [
    clownfish
    fishtape_3
  ];

  checkFunctionDirs = [ "./functions" ];

  checkPhase =
    ""
    + (
      if stdenv.hostPlatform.isDarwin then
        ''script /dev/null fish -c "fishtape tests/*/*.fish"''
      else
        ''script -c 'fish -c "fishtape tests/*/*.fish"' ''
    );

  meta = {
    description = "Configurable fzf completions for fish shell ";
    homepage = "https://github.com/xxxbrian/fzf-tab.fish";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ rein ];
  };
}
