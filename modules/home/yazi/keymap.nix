{
  mgr.prepend_keymap = [
    {
      on = [ "l" ];
      run = "plugin bypass smart-enter";
      desc = "Open a file, or recursively enter child directory, skipping children with only a single subdirectory";
    }
    {
      on = [ "H" ];
      run = "plugin bypass reverse";
      desc = "Recursively enter parent directory, skipping parents with only a single subdirectory";
    }

    {
      on = [ "C" ];
      run = "plugin ouch";
      desc = "Compress with ouch";
    }

    {
      on = [
        "c"
        "m"
      ];
      run = "plugin chmod";
      desc = "Chmod on selected files";
    }

    {
      on = [
        "R"
        "p"
      ];
      run = "plugin sudo -- paste";
      desc = "Paste yanked file(s) using sudo";
    }
    {
      on = [
        "R"
        "P"
      ];
      run = "plugin sudo -- paste --force";
      desc = "Paste yanked file(s) (overwrite if the destination exists) using sudo";
    }
    {
      on = [
        "R"
        "r"
      ];
      run = "plugin sudo -- rename";
      desc = "Rename selected file(s) using sudo";
    }
    {
      on = [
        "R"
        "a"
      ];
      run = "plugin sudo -- create";
      desc = "Create a file (ends with / for directories) using sudo";
    }
    {
      on = [
        "R"
        "d"
      ];
      run = "plugin sudo -- remove";
      desc = "Trash selected file(s) using sudo";
    }
    {
      on = [
        "R"
        "D"
      ];
      run = "plugin sudo -- remove --permanently";
      desc = "Permamently delete selected file(s) using sudo";
    }
  ];
}
