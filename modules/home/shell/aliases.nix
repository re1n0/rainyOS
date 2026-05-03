{
  # misc
  icat = "chafa -f iterm";
  ps = "procs";

  # ls
  exa = "eza --icons --git";
  l = "eza --icons --git -lo --no-user --no-permissions --no-time";
  ll = "eza --icons --git -l";
  ls = "eza --icons --git -lo --no-user --no-permissions --no-time";
  la = "eza --icons --git -lo --no-user --no-permissions --no-time -a";

  # tree
  t = "eza --icons --git --tree";
  tree = "eza --icons --git --tree";
  tl = "eza --icons --git -l --tree";

  # cat
  cat = "bat";

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
  logout = "loginctl terminate-session (cat /proc/self/sessionid)";
}
