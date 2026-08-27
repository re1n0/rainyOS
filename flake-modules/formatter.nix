_: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    formatter = pkgs.treefmt.withConfig {
      runtimeInputs = with pkgs; [
        # keep-sorted start block=yes
        alejandra
        deadnix
        keep-sorted
        nixfmt
        prettier
        statix
        stylua
        # keep-sorted end
      ];
      settings = {
        excludes = [
          ".gitignore"
        ];

        formatter = {
          # keep-sorted start block=yes newline_separated=yes
          alejandra = {
            command = "alejandra";
            includes = ["*.nix"];
          };

          deadnix = {
            command = "deadnix";
            includes = ["*.nix"];
            options = ["--edit"];
          };

          keep-sorted = {
            command = "keep-sorted";
            includes = ["*"];
          };

          prettier = {
            command = "prettier";
            includes = [
              "*.json"
              "*.sass"
              "*.scss"
            ];
            options = ["--write"];
          };

          statix = {
            command = pkgs.writeShellScript "statix-fix" ''
              for file in "$@"; do
                ${lib.getExe pkgs.statix} fix "$file"
              done
            '';
            includes = [
              "*.nix"
            ];
          };

          stylua = {
            command = "stylua";
            includes = ["*.lua"];
          };
          # keep-sorted end
        };
      };
    };
  };
}
