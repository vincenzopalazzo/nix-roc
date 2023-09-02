{
  description = "Roc Language nightly template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    roc-lang.url = "https://github.com/roc-lang/roc/archive/main.tar.gz";
  };

  outputs = { self, nixpkgs, roc-lang, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages = {
          default = pkgs.just;
        };

        formatter = pkgs.nixpkgs-fmt;

        devShell = pkgs.mkShell {
          buildInputs = [ pkgs.just roc-lang ];
          shellHook = ''
            alias make=just
          '';
        };

      });
}
