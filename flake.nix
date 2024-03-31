{
  description = "Roc Language nightly template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    roc.url = "github:roc-lang/roc";
  };

  outputs = { self, nixpkgs, flake-utils, roc }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        rocPkgs = roc.packages.${system};

        linuxInputs = with pkgs;
          lib.optionals stdenv.isLinux [
          ];

        darwinInputs = with pkgs;
          lib.optionals stdenv.isDarwin
            (with pkgs.darwin.apple_sdk.frameworks; [
            ]);

        sharedInputs = (with pkgs; [
          expect
          rocPkgs.cli
        ]);
      in
      {

        devShell = pkgs.mkShell {
          buildInputs = sharedInputs ++ darwinInputs ++ linuxInputs;
        };

        formatter = pkgs.nixpkgs-fmt;
      });
}
