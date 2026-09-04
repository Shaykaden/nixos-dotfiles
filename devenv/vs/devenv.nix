{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  #packages = with pkgs; [ glib ];
  packages = with pkgs; [
    dbus.lib
    libGL.out
    fontconfig.lib
    libxkbcommon.out
    freetype.out
    libpulseaudio.out
    krb5.lib
    libxcb-cursor
    kdePackages.qtbase.out
  ];

  languages.python = {
    enable = true;
    manylinux.enable = true;

    venv = {
      enable = true;
      quiet = true;
    };

    uv = {
      enable = true;
      sync = {
        enable = true;
        allExtras = true;
      };
    };
  };

  scripts.postinstall.exec = ''
    vapoursynth config
  ''; # used vapoursynth register-install to make it visible in the VSSCRIPT_PATH ? or get it declaritavely

}
