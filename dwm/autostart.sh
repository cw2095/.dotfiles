#!/bin/bash

dwmblocks &

/bin/bash /home/cw/.dotfiles/bin/wp_autochange.sh &

# mailsync &
# chk.packages.sh &

picom -b

xfce4-power-manager &

fcitx5 &

