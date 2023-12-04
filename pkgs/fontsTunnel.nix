{ lib, buildFont }:

buildFont {
  name = "fontsTunnel";
  srcs = [
    ./fonts/Grade.ttf
    # Add more font files as needed
  ];
}
