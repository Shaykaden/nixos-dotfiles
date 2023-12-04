# { lib, stdenv, fetchurl, makeWrapper, pkgs }:
#
# with lib;
# stdenv.mkDerivation {
#    pname = "Aegisub";
#    version = "11";
#    src = fetchurl {
#       url = "https://github.com/arch1t3cht/Aegisub/archive/refs/tags/feature_11.tar.gz";
#       hash = "sha256-IOxtBC14efigoad4yiGXpZIWQoxOw11mnvK5PnvVUSA=";
#    };
#
# # shellHook = "export BOOST_INCLUDEDIR=${pkgs.lib.getDev pkgs.boost}/include; export BOOST_LIBRARYDIR=${pkgs.lib.getLib pkgs.boost}/lib";
#    BOOST_INCLUDEDIR = "${pkgs.lib.getDev pkgs.boost}/include";
#    BOOST_LIBRARYDIR = "${pkgs.lib.getLib pkgs.boost}/lib";
#
#    nativeBuildInputs = with pkgs; 
#    [  
#       alsa-lib
#       fftw
#       fontconfig
#       glibc
#       hunspell
#       icu
#       libass
#       ffms
#       libGL
#       libiconv
#       libuchardet
#       wxGTK32
#       zlib
#
#       pkg-config
#       glibc
#       git
#       intltool
#       lua
#       mesa
#       meson 
#
#       cmake
#       libpulseaudio
#       portaudio
#       openal
#       ninja
#       glibc
#       ];
#    buildPhase = ''
#       meson setup build --buildtype=release
#       cd build
#       ninja
#       '';
#
# # installPhase = ''
# #   mkdir -p $out/bin
# #   cp aegisub $out/bin
# # '';
#
#    meta = {
#       description = "A miniature cava sound visualizer";
#       homepage = "https://github.com/Misterio77/minicava";
#       license = licenses.mit;
#       platforms = platforms.all;
#    };
# }


{ lib
, config
, stdenv
, fetchurl
, pkgs
, boost179
, cmake
, expat
, harfbuzz
, ffmpeg
, ffms
, fftw
, fontconfig
, freetype
, fribidi
, glib
, icu
, intltool
, libGL
, libGLU
, libX11
, libass
, libiconv
, libuchardet
, luajit
, pcre
, pkg-config
, which
, wrapGAppsHook
, wxGTK
, zlib

, spellcheckSupport ? true
, hunspell ? null

, openalSupport ? false
, openal ? null

, alsaSupport ? stdenv.isLinux
, alsa-lib ? null

, pulseaudioSupport ? config.pulseaudio or stdenv.isLinux
, libpulseaudio ? null

, portaudioSupport ? false
, portaudio ? null

, useBundledLuaJIT ? false
, darwin
}:

assert spellcheckSupport -> (hunspell != null);
assert openalSupport -> (openal != null);
assert alsaSupport -> (alsa-lib != null);
assert pulseaudioSupport -> (libpulseaudio != null);
assert portaudioSupport -> (portaudio != null);

let
  luajit52 = luajit.override { enable52Compat = true; };
  inherit (lib) optional;
  inherit (darwin.apple_sdk.frameworks) CoreText CoreFoundation AppKit Carbon IOKit Cocoa;
in
stdenv.mkDerivation rec {
  pname = "aegisube";
  version = "11";

   src = fetchurl {
      url = "https://github.com/arch1t3cht/Aegisub/archive/refs/tags/feature_11.tar.gz";
      hash = "sha256-IOxtBC14efigoad4yiGXpZIWQoxOw11mnvK5PnvVUSA=";
   };

   BOOST_INCLUDEDIR = "${pkgs.lib.getDev pkgs.boost}/include";
   BOOST_LIBRARYDIR = "${pkgs.lib.getLib pkgs.boost}/lib";

  nativeBuildInputs = [
    intltool
    luajit52
    pkg-config
    which
    cmake
    wrapGAppsHook
  ];

  buildInputs = [
    # boost179
    expat
    ffmpeg
    ffms
    fftw
    fontconfig
    freetype
    fribidi
    glib
    harfbuzz
    icu
    libGL
    libGLU
    libX11
    libass
    libiconv
    libuchardet
    pcre
    wxGTK
    zlib
  ] ;

  # enableParallelBuilding = true;
  #
  # hardeningDisable = [
  #   "bindnow"
  #   "relro"
  # ];


   buildPhase = ''
      meson setup build --buildtype=release
      cd build
      ninja
      '';
  # patches = lib.optionals (!useBundledLuaJIT) [
  #   ./remove-bundled-luajit.patch
  # ];
  #
  # # error: unknown type name 'NSUInteger'
  # postPatch = ''
  #   substituteInPlace src/dialog_colorpicker.cpp \
  #     --replace "NSUInteger" "size_t"
  # '';
  #
  # env.NIX_CFLAGS_COMPILE = "-I${luajit52}/include";
  # NIX_CFLAGS_LINK = "-L${luajit52}/lib";
  #
  # configurePhase = ''
  #   export FORCE_GIT_VERSION=${version}
  #   # Workaround for a Nixpkgs bug; remove when the fix arrives
  #   mkdir build-dir
  #   cd build-dir
  #   cmake -DCMAKE_INSTALL_PREFIX=$out ..
  # '';

  # meta = with lib; {
    # homepage = "https://github.com/wangqr/Aegisub";
    # description = "An advanced subtitle editor";
    # longDescription = ''
    #   Aegisub is a free, cross-platform open source tool for creating and
    #   modifying subtitles. Aegisub makes it quick and easy to time subtitles to
    #   audio, and features many powerful tools for styling them, including a
    #   built-in real-time video preview.
    # '';
    # # The Aegisub sources are itself BSD/ISC, but they are linked against GPL'd
    # # softwares - so the resulting program will be GPL
    # license = licenses.bsd3;
    # maintainers = with maintainers; [ AndersonTorres wegank ];
    # platforms = platforms.unix;
    # mainProgram = "aegisub";
  # };
}
