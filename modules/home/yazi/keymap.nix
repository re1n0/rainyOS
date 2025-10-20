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

    {
      on = [
        "M"
        "m"
      ];
      run = "plugin gvfs -- select-then-mount --jump";
      desc = "Select device to mount and jump to its mount point";
    }
    {
      on = [
        "M"
        "R"
      ];
      run = "plugin gvfs -- remount-current-cwd-device";
      desc = "Remount device under cwd";
    }
    {
      on = [
        "M"
        "u"
      ];
      run = "plugin gvfs -- select-then-unmount";
      desc = "Select device then unmount";
    }
    {
      on = [
        "M"
        "U"
      ];
      run = "plugin gvfs -- select-then-unmount --eject --force";
      desc = "Select device then force to eject";
    }
    {
      on = [
        "M"
        "a"
      ];
      run = "plugin gvfs -- add-mount";
      desc = "Add a GVFS mount URI";
    }
    {
      on = [
        "M"
        "e"
      ];
      run = "plugin gvfs -- edit-mount";
      desc = "Edit a GVFS mount URI";
    }
    {
      on = [
        "M"
        "r"
      ];
      run = "plugin gvfs -- remove-mount";
      desc = "Remove a GVFS mount URI";
    }
    {
      on = [
        "g"
        "m"
      ];
      run = "plugin gvfs -- jump-to-device --automount";
      desc = "Automount then select device to jump to its mount point";
    }
    {
      on = [
        "`"
        "`"
      ];
      run = "plugin gvfs -- jump-back-prev-cwd";
      desc = "Jump back to the position before jumped to device";
    }
    {
      on = [
        "M"
        "t"
      ];
      run = "plugin gvfs -- automount-when-cd";
      desc = "Enable automount when cd to device under cwd";
    }
    {
      on = [
        "M"
        "T"
      ];
      run = "plugin gvfs -- automount-when-cd --disabled";
      desc = "Disable automount when cd to device under cwd";
    }
  ];
}
