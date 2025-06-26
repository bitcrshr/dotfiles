{ pkgs, ... }: {
  programs.helix.languages = {
    language-server = {
      gopls = {
        goimports = true;
        gofumpt = true;
        staticcheck = true;
      };

      # https://github.com/helix-editor/helix/issues/13501
      golangci-lint2-langserver = {
        command = "golangci-lint-langserver";
        config = {
          command = [
            "golangci-lint"
            "run"
            "--output.json.path"
            "stdout"
            "--show-stats=false"
            "--issues-exit-code=1"
          ];
        };
      };
    };

    language = [
      {
        name = "go";
        auto-format = true;
        language-servers = [ "gopls" "golangci-lint2-langserver" ];
      }


      {
        name = "rust";
        auto-format = true;
      }

      {
        name = "json";
        formatter = {
          command = "prettier";
          args = [ "--parser" "json" ];
        };
        auto-format = true;
        indent = {
          tab-width = 4;
          unit = "    ";
        };
      }

      {
        name = "html";
        formatter = {
          command = "prettier";
          args = [ "--parser" "html" ];
        };
        indent = {
          tab-width = 4;
          unit = "    ";
        };
      }

      {
        name = "svelte";
        indent = {
          tab-width = 4;
          unit = "    ";
        };
        auto-format = true;
        language-servers = [ "svelteserver" "tailwindcss-ls" ];
      }

      {
        name = "nix";
        indent = {
          tab-width = 4;
          unit = "    ";
        };
        auto-format = true;
        formatter = {
          command = "nixpkgs-fmt";
        };
      }
    ];
  };
}
