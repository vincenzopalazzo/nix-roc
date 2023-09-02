{
  description = "Roc Language nightly template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";

    crane = {
      url = "github:ipetkov/crane";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, crane }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
          craneLib = crane.lib.${system};
          roc = crane.lib.${system}.downloadCargoPackageFromGit {
            git = "https://github.com/roc-lang/roc.git";
            rev = "bf937b2b38d338072ba1f440c493015e9b583751";
          };
      in {
        packages = {
          default = roc;
        };

        formatter = pkgs.nixpkgs-fmt;

        devShell = pkgs.mkShell {
          nativeBuildInputs = [ pkgs.just pkgs.git ];
          shellHook = ''
            alias make=just
          '';
        };

      });
}
