{ lib, config, pkgs, ... }:

let
  apps = import ./applications.nix { inherit pkgs; };

in {
  programs.niri.settings.binds = with config.lib.niri.actions; let
    pactl = "${pkgs.pulseaudio}/bin/pactl";
    dms-ipc = spawn "dms" "ipc";

    #volume-up = spawn pactl [ "set-sink-volume" "@DEFAULT_SINK@" "+5%" ];
    #volume-down = spawn pactl [ "set-sink-volume" "@DEFAULT_SINK@" "-5%" ];
  in {
    "super+t".action = spawn "alacritty";
    "super+q".action = close-window;
    #"super+b".action = spawn apps.browser;
    "super+h".action = focus-column-left;
    "super+l".action = focus-column-right;
    "super+j".action = focus-window-or-workspace-down;
    "super+k".action = focus-window-or-workspace-up;

    "super+Shift+h".action = move-column-left;
    "super+Shift+l".action = move-column-right;
    "super+Shift+j".action = move-window-down-or-to-workspace-down;
    "super+Shift+k".action = move-window-up-or-to-workspace-up;

    "super+Shift+1".action.move-window-to-workspace = 1;
    "super+Shift+2".action.move-window-to-workspace = 2;
    "super+Shift+3".action.move-window-to-workspace = 3;
    "super+Shift+4".action.move-window-to-workspace = 4;

    # TODO: add +10% -10% on [ ] 
    # TODO: fix le petit decalement
    "super+u".action = set-column-width "100%";
    "super+alt+u".action = set-column-width "50%";
    "super+alt+i".action = set-column-width "33.333%";
    "super+i".action = set-column-width "66.667%";
    "super+o".action = set-column-width "+10%";
    "super+p".action = set-column-width "-10%";

    "super+Alt+h".action = move-column-left;
    "super+Alt+l".action = move-column-right;
    "super+Alt+j".action = move-window-down-or-to-workspace-down;
    "super+Alt+k".action = move-window-up-or-to-workspace-up;


    "super+1".action = focus-workspace 1;
    "super+2".action = focus-workspace 2;
    "super+3".action = focus-workspace 3;
    "super+4".action = focus-workspace 4;

    "super+r".action = toggle-overview;
    "super+g".action = toggle-window-floating;
    "super+f".action = fullscreen-window;


    # TODO : scroll more smooth please
    "super+WheelScrollDown".action = focus-column-right;
    "super+WheelScrollUp".action = focus-column-left;

    "super+alt+WheelScrollDown".action = focus-workspace-down;
    "super+alt+WheelScrollUp".action = focus-workspace-up;

    "super+Space" = {
	    action = dms-ipc "spotlight" "toggle";
	    hotkey-overlay.title = "Toggle Application Launcher";
    };
    "super+N" = {
	    action = dms-ipc "notifications" "toggle";
	    hotkey-overlay.title = "Toggle Notification Center";
    };
    "super+Comma" = {
	    action = dms-ipc "settings" "toggle";
	    hotkey-overlay.title = "Toggle Settings";
    };
    "super+alt+P" = {
	    action = dms-ipc "notepad" "toggle";
	    hotkey-overlay.title = "Toggle Notepad";
    };
    "Super+Alt+d" = {
	    action = dms-ipc "lock" "lock";
	    hotkey-overlay.title = "Toggle Lock Screen";
    };
    "super+X" = {
	    action = dms-ipc "powermenu" "toggle";
	    hotkey-overlay.title = "Toggle Power Menu";
    };
    "XF86AudioRaiseVolume" = {
	    allow-when-locked = true;
	    action = dms-ipc "audio" "increment" "3";
    };
    "XF86AudioLowerVolume" = {
	    allow-when-locked = true;
	    action = dms-ipc "audio" "decrement" "3";
    };
    "XF86AudioMute" = {
	    allow-when-locked = true;
	    action = dms-ipc "audio" "mute";
    };
    "XF86AudioMicMute" = {
	    allow-when-locked = true;
	    action = dms-ipc "audio" "micmute";
    };
    "super+Alt+N" = {
	    allow-when-locked = true;
	    action = dms-ipc "night" "toggle";
	    hotkey-overlay.title = "Toggle Night supere";
    };
  };
}
