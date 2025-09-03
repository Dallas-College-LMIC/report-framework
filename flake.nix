{
  description = "Python project template with modern tooling";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ruler = {
      url = "github:intellectronica/ruler";
      flake = false;
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.git-hooks.flakeModule
      ];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem =
        {
          config,
          pkgs,
          ...
        }:
        let
          python = pkgs.python313;

          # Build ruler CLI tool (auto-updating from flake input)
          ruler-pkg = pkgs.buildNpmPackage {
            pname = "ruler";
            version = "latest";

            src = inputs.ruler;

            npmDepsHash = "sha256-XRcVHK45qBUVXsrHSGS88aJ8XMRR+5eQ+jgwBEmgnc8=";

            # The package has a prepare script that runs the build
            npmBuildScript = "build";

            meta = {
              description = "Centralise Your AI Coding Assistant Instructions";
              homepage = "https://github.com/intellectronica/ruler";
            };
          };

        in
        {
          # Pre-commit hooks configuration
          pre-commit = {
            check.enable = true;
            settings = {
              hooks = {
                # Python formatters, linters, and typecheckers
                ruff.enable = true;
                ruff-format.enable = true;
                mypy = {
                  enable = true;
                  entry = "${pkgs.uv}/bin/uv run mypy";
                };

                # General file hygiene
                trim-trailing-whitespace.enable = true;
                end-of-file-fixer.enable = true;
                check-merge-conflicts.enable = true;
                check-added-large-files = {
                  enable = true;
                  args = [ "--maxkb=5000" ];
                };
                check-yaml.enable = true;
                check-json.enable = true;
                check-toml.enable = true;
                check-python.enable = true; # Check Python AST

                # Nix
                flake-checker.enable = true;
                nixfmt-rfc-style.enable = true;
                deadnix = {
                  enable = true;
                  settings.edit = true;
                };
                statix.enable = true;
              };
            };
          };

          devShells.default = pkgs.mkShell {
            buildInputs = [
              # Python and package management
              python
              pkgs.uv
              ruler-pkg

              # System libraries for numpy/pandas
              pkgs.stdenv.cc.cc.lib
              pkgs.zlib
            ]
            ++ (with pkgs.python313Packages; [
              debugpy
              python-lsp-server
              python-lsp-ruff
              pylsp-mypy
            ])
            # Add pre-commit enabled packages
            ++ config.pre-commit.settings.enabledPackages;

            env = {
              UV_PYTHON_DOWNLOADS = "never";
              UV_PYTHON = python.interpreter;
            };

            shellHook = ''
              # Run the pre-commit shellHook first
              ${config.pre-commit.installationScript}

              echo "🐍 Python Development Environment"
              echo "Python: ${python.version}"

              # Set up environment
              unset PYTHONPATH
              export PYTHONPATH="$PWD:$PYTHONPATH"

              # Set LD_LIBRARY_PATH for numpy and other C extensions
              export LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.zlib}/lib:$LD_LIBRARY_PATH"

              # Python virtual environment setup
              if [[ ! -d .venv ]]; then
                echo "Creating Python virtual environment..."
                uv venv
                uv sync
              else
                source .venv/bin/activate
                # Only sync if pyproject.toml is newer than .venv
                if [[ pyproject.toml -nt .venv ]]; then
                  echo "Dependencies may have changed, running uv sync..."
                  uv sync
                fi
              fi
            '';
          };

        };
    };
}
