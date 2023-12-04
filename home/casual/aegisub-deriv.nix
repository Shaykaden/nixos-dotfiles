{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "aegisub";

  src = pkgs.fetchurl {
    url = "https://github.com/wangqr/Aegisub/archive/refs/tags/v3.3.3.zip";
    sha256 = "1jdk14qfgyvgcbb1icibjk5l3cy3nwkydqkkvcvqaldmxi3fpb8w";
  };

  installPhase = ''
    ./autogen.sh
    ./configure
    make
  ''
}
