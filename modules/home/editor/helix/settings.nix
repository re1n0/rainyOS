{
  theme = "rainy";

  editor = {
    bufferline = "multiple";
    color-modes = true;
    true-color = true;

    gutters.layout = [
      "diff"
      "diagnostics"
      "line-numbers"
      "spacer"
    ];

    statusline = {
      left = [
        "separator"
        "mode"
        "file-base-name"
        "position"
        "position-percentage"
        "workspace-diagnostics"
      ];
      center = [
        "spinner"
        "file-type"
      ];
      right = [
        "file-encoding"
        "file-line-ending"
        "version-control"
        "separator"
      ];
      separator = "▊";
      mode = {
        normal = " ";
        insert = " ";
        select = " ";
      };
    };

    lsp.display-messages = true;

    cursor-shape = {
      insert = "bar";
      normal = "block";
      select = "underline";
    };

    indent-guides.render = true;

    whitespace.render = {
      nbsp = "all";
      nnbsp = "all";
    };

    whitespace.characters = {
      nbsp = "⍽";
      nnbsp = "␣";
    };
  };
}
