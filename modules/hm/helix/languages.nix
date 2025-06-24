{ pkgs, ... }: {
  programs.helix.languages = {
    language-server.gopls = {
      goimports = true;
      gofumpt = true;
      staticcheck = false;
    };

    language = [
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
