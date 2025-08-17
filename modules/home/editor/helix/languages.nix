{
  language = [
    {
      name = "html";
      file-types = [
        "html"
        { glob = "*.html.hbs"; }
      ];
    }

    {
      name = "java";
      roots = [ "build.gradle" ];
      auto-format = true;
    }

    {
      name = "jinja";
      language-servers = [ "jinja-lsp" ];
    }

    {
      name = "nix";
      auto-format = true;
      formatter.command = "nixfmt";
    }

    {
      name = "scss";
      scope = "source.scss";
      injection-regex = "scss";
      file-types = [ "scss" ];
      block-comment-tokens = {
        start = "/*";
        end = "*/";
      };
      language-servers = [
        "vscode-css-language-server"
        "some-sass"
      ];
      auto-format = true;
      indent = {
        tab-width = 2;
        unit = "  ";
      };
    }

    {
      name = "javascript";
      language-servers = [
        {
          name = "typescript-language-server";
          except-features = [ "format" ];
        }
        "biome"
      ];
      auto-format = true;
    }

    {
      name = "jsx";
      language-servers = [
        {
          name = "typescript-language-server";
          except-features = [ "format" ];
        }
        "biome"
      ];
      auto-format = true;
    }

    {
      name = "typescript";
      language-servers = [
        {
          name = "typescript-language-server";
          except-features = [ "format" ];
        }
        "biome"
      ];
      auto-format = true;
    }

    {
      name = "tsx";
      language-servers = [
        {
          name = "typescript-language-server";
          except-features = [ "format" ];
        }
        "biome"
      ];
      auto-format = true;
    }

    {
      name = "json";
      language-servers = [
        {
          name = "vscode-json-language-server";
          except-features = [ "format" ];
        }
        "biome"
      ];
      auto-format = true;
    }
  ];

  language-server = {
    biome = {
      command = "biome";
      args = [ "lsp-proxy" ];
    };

    jinja-lsp = {
      command = "jinja-lsp";
      config = {
        templates = "./templates";
        backend = [ "./src" ];
        lang = "rust";
      };
      timeout = 5;
    };

    qmlls = {
      args = [ "-E" ];
      command = "qmlls";
    };

    rust-analyzer.config.diagnostics.disabled = [ "unlinked-file" ];

    some-sass = {
      command = "some-sass-language-server";
      args = [ "--stdio" ];
      timeout = 5;
    };

    vscode-css-language-server.config = {
      css.validate.enable = true;
      scss.validate.enable = true;
      less.validate.enable = true;
      provideFormatter = true;
    };
  };
}
