{ pkgs, ... }:
{
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

      atlas = {
        command = "atlas";
        args = [
          "tool"
          "lsp"
          "--stdio"
        ];
      };

      tailwindcss-ls = {
        command = "tailwindcss-language-server";
        args = [ "--stdio" ];
      };

      astro-ls = {
        command = "astro-ls";
        args = [ "--stdio" ];
        config = {
          typescript = {
            tsdk = "${pkgs.typescript}/lib/node_modules/typescript/lib";
            environment = "node";
          };
        };
      };
    };
    language = [
      {
        name = "go";
        auto-format = true;
        language-servers = [
          "gopls"
          "golangci-lint2-langserver"
        ];
      }

      {
        name = "rust";
        auto-format = true;
      }

      {
        name = "json";
        formatter = {
          command = "prettier";
          args = [
            "--parser"
            "json"
          ];
        };
        auto-format = true;
        indent = {
          tab-width = 4;
          unit = "    ";
        };
      }

      {
        name = "html";
        language-servers = [
          "vscode-html-language-server"
          "tailwindcss-ls"
        ];
        auto-format = false;
        formatter = {
          command = "prettier";
          args = [
            "--parser"
            "html"
          ];
        };
        indent = {
          tab-width = 4;
          unit = "    ";
        };
      }

      {
        name = "astro";
        language-servers = [
          "astro-ls"
          "tailwindcss-ls"
        ];
        auto-format = false;
        formatter = {
          command = "prettier";
          args = [
            "--plugin"
            "prettier-plugin-astro"
            "--plugin"
            "prettier-plugin-tailwindcss"
            "--parser"
            "astro"
          ];
        };
      }

      {
        name = "svelte";
        indent = {
          tab-width = 4;
          unit = "    ";
        };
        auto-format = true;
        language-servers = [
          "svelteserver"
          "tailwindcss-ls"
        ];
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

      {
        name = "ocaml";
        auto-format = true;
        formatter.command = "ocamlformat";
      }
    ]
    ++ (
      let
        mappings = {
          "atlas.hcl" = "atlas-config";
          "pg.hcl" = "atlas-schema-postgresql";
          "lt.hcl" = "atlas-schema-sqlite";
          "test.hcl" = "atlas-test";
          "plan.hcl" = "atlas-plan";
          "rule.hcl" = "atlas-rule";
        };
      in
      builtins.map
        (key: rec {
          name = mappings.${key};
          scope = "text.${name}";
          language-id = mappings.${key};
          file-types = [ key ];
          language-servers = [ "atlas" ];
          grammar = "hcl";
        })
        (builtins.attrNames mappings)
    );
  };
}
