{
  # misc
  icat = "mcat --kitty";
  grep = "grep --color=always";

  # ls
  l = "eza -lo --no-user --no-permissions --no-time";
  ll = "eza -l";
  ls = "eza -lo --no-user --no-permissions --no-time";
  la = "eza -lo --no-user --no-permissions --no-time -a";

  # tree
  t = "eza --tree";
  tree = "eza --tree";
  tl = "eza -l --tree";

  # editor
  v = "$EDITOR";

  # clock & fetch
  clock = "rsclock -S -c";
  starf = "astroterm -cmu -r 2.0";

  # nix
  ncg = "nh clean all -a && sudo /run/current-system/bin/switch-to-configuration boot";
  nrs = "nh os switch -a";
  nrb = "nh os boot -a";

  # power
  reboot = "systemctl reboot";
  poweroff = "systemctl poweroff";
  suspend = "systemctl suspend";
  logout = "loginctl terminate-session auto";
}
