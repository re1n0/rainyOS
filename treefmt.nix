{
  on-unmatched = "info";

  formatter = {
    alejandra = {
      command = "alejandra";
      includes = ["*.nix"];
    };

    prettier = {
      command = "prettier";
      options = ["--write"];
      includes = ["*.scss" "*.sass" "*.json"];
    };

    stylua = {
      command = "stylua";
      includes = ["*.lua"];
    };

    shfmt = {
      command = "shfmt";
      options = ["-w"];
      includes = ["*.sh"];
    };

    yamlfmt = {
      command = "yamlfmt";
      includes = ["*.yml" "*.yaml"];
    };
  };
}
