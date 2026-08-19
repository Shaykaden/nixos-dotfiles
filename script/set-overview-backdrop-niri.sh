SCREENS=$(grep -l '^connected$' /sys/class/drm/card*-*/status | xargs -n1 dirname | xargs -n1 basename | cut -d- -f2- | xargs); for SCREEN in $SCREENS; do WP=$(dms ipc wallpaper getFor $SCREEN) && magick "$WP" -blur 0x16 "/tmp/$SCREEN-blur.jpg" && swaybg -m fill -o $SCREEN -i "/tmp/$SCREEN-blur.jpg" & done

