{
  lib,
  buildFishPlugin,
  pins,
}:
let
  inherit (pins) fzf-tab-fish;
in
buildFishPlugin {
  pname = "fzf-tab";
  version = "0-git+${fzf-tab-fish.revision}";

  src = fzf-tab-fish;

  meta = {
    description = "Configurable fzf completions for fish shell ";
    homepage = "https://github.com/xxxbrian/fzf-tab.fish";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ rein ];
  };
}
