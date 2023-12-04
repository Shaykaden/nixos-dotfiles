{ pkgs, inputs, ... }:
{
  imports = [
    inputs.xremap-flake.homeManagerModules.default
  ];

  services.xremap = {
    withHypr = true;
    # userName = "alice";  # run as a systemd service in alice
    # serviceMode = "user";  # run xremap as user
    services.xremap = {
    yamlConfig = ''
      modmap:
        - name: hello;
            remap:
              KEY_BACKSPACE: esc
    '';
  };
}
