{ pkgs ? import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/fafa4f5650d530eb257692066c2a1bd017a5c342.tar.gz";
  }) {}
}: pkgs.stdenv.mkDerivation rec {
  pname = "roc-lang";
  version = "0.0.1";

  src = pkgs.fetchgit {
    url = "https://github.com/roc-lang/roc.git";
    rev = "d917c7daf13bb50850e872bab006ba5c7b1c23a9";
    sha256 = "sha256-OVVUY2kNEMJgtRfo0Vq6APcCYQrXSqNkNaaPizfRF68=";
  };

  buildInputs = with pkgs; [
      git
      pkgs.llvmPackages_13.llvm.dev
      pkgs.llvmPackages_13.clang
      libxkbcommon
      pkg-config
      zig_0_9 # roc builtins are implemented in zig, see compiler/builtins/bitcode/

      # lib deps
      libffi
      libxml2
      ncurses
      zlib
      libiconv

      rustc
      cargo
  ];

  installPhase = ''
     cargo install --path ./crates/compiler/
  '';
}
