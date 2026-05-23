{
  lib,
  buildFishPlugin,
  rainySources,
}:
buildFishPlugin {
  inherit (rainySources."fzf-tab.fish")
    pname
    version
    src
    date
    ;

  meta = {
    description = "Configurable fzf completions for fish shell ";
    homepage = "https://github.com/xxxbrian/fzf-tab.fish";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ rein ];
  };
}
