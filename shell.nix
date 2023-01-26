{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/06278c77b5d162e62df170fec307e83f1812d94b.tar.gz") {} }:

 pkgs.mkShell {
   buildInputs = [
     pkgs.love
     pkgs.luajitPackages.moonscript
     pkgs.luajitPackages.luarocks
     pkgs.luajitPackages.luasec
     pkgs.luajitPackages.luasocket
     pkgs.luajitPackages.luaossl
     pkgs.openssl
     pkgs.pixelorama
     pkgs.libresprite
   ];

   OPENSSL_DEVDIR = "${pkgs.openssl.dev}";
   OPENSSL_OUTDIR = "${pkgs.openssl.out}";
 }