{
  plugin.prepend_fetchers = [
    {
      id = "git";
      name = "*";
      run = "git";
    }
    {
      id = "git";
      name = "*/";
      run = "git";
    }
  ];

  plugin.prepend_preloaders = [
    {
      mime = "{audio,video,image}/*";
      run = "mediainfo";
    }
    {
      mime = "application/subrip";
      run = "mediainfo";
    }
    {
      mime = "application/postscript";
      run = "mediainfo";
    }

    {
      name = "/run/user/1000/gvfs/**/*";
      run = "noop";
    }
    {
      name = "/run/media/USER_NAME/**/*";
      run = "noop";
    }
  ];

  plugin.prepend_previewers = [
    {
      name = "*.md";
      run = "glow";
    }

    {
      mime = "application/*zip";
      run = "ouch";
    }
    {
      mime = "application/x-tar";
      run = "ouch";
    }
    {
      mime = "application/x-bzip2";
      run = "ouch";
    }
    {
      mime = "application/x-7z-compressed";
      run = "ouch";
    }
    {
      mime = "application/x-rar";
      run = "ouch";
    }
    {
      mime = "application/vnd.rar";
      run = "ouch";
    }
    {
      mime = "application/x-xz";
      run = "ouch";
    }
    {
      mime = "application/xz";
      run = "ouch";
    }
    {
      mime = "application/x-zstd";
      run = "ouch";
    }
    {
      mime = "application/zstd";
      run = "ouch";
    }
    {
      mime = "application/java-archive";
      run = "ouch";
    }

    {
      mime = "{audio,video,image}/*";
      run = "mediainfo";
    }
    {
      mime = "application/subrip";
      run = "mediainfo";
    }
    {
      mime = "application/postscript";
      run = "mediainfo";
    }

    {
      name = "*/";
      run = "folder";
    }
    {
      mime = "{text/*,application/x-subrip}";
      run = "code";
    }
    {
      name = "/run/user/1000/gvfs/**/*";
      run = "noop";
    }
    {
      name = "/run/media/USER_NAME/**/*";
      run = "noop";
    }
  ];

  plugin.append_previewers = [
    {
      name = "*";
      run = ''piper -- hexyl --border=none --terminal-width=$w "$1"'';
    }
  ];

  opener = {
    extract = [
      {
        run = "ouch d -y %*";
        desc = "Extract here with ouch";
        for = "windows";
      }
      {
        run = ''ouch d -y "$@"'';
        desc = "Extract here with ouch";
        for = "unix";
      }
    ];
  };
}
