{
  # misc
  q = "exit";
  c = "clear";
  icat = "kitty icat";
  s = "kitten ssh";

  # ls
  exa = "eza --icons --git";
  l = "exa -lo --no-user --no-permissions --no-time";
  ll = "exa -l";
  ls = "l";
  la = "l -a";

  # tree
  t = "exa --tree";
  tree = "t";
  tl = "ll --tree";

  # du
  du = "dust";

  # cat
  cat = "bat";

  # utils
  cf = "wl-copy <";
  pf = "wl-paste >";
  cv = "ffmpeg -i";

  # editor
  v = "$EDITOR";

  # music player
  mp = "rmpc";

  # YouTube download
  ytdl = "yt-dlp";

  # clock
  clock = "rsclock -S -c";

  # fetch
  ff = "fastfetch";
  starf = "astroterm -cmu -r 2.0";
  gitf = "tokei";

  # password store
  pass = "gopass";

  # nix
  ncg = "nh clean all -a && sudo /run/current-system/bin/switch-to-configuration boot";
  nrs = "nh os switch -a";
  nrb = "nh os boot -a";

  # power
  reboot = "systemctl reboot";
  poweroff = "systemctl poweroff";
  suspend = "systemctl suspend";
  logout = "loginctl terminate-session $(< /proc/self/sessionid)";
}
