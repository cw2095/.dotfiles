#!/bin/sh

# In the X Window System, the X resources are parameters of computer programs such as the name of the font used in the buttons, the background color of menus, etc. 
# They are used in conjunction with or as an alternative to command line parameters and configuration files.

# Xmodmap is a utility for modifying keymaps and pointer button mappings in Xorg.

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

xset +fp /usr/share/fonts/adobe-source-code-pro
xset +fp /usr/share/fonts/adobe-source-han-sans
xset +fp /usr/share/fonts/adobe-source-han-serif
xset +fp /usr/share/fonts/misc
xset +fp /usr/share/fonts/util
xset +fp /usr/share/fonts/droid
xset +fp /usr/share/fonts/cyrillic
xset +fp /usr/share/fonts/encodings
xset +fp /usr/share/fonts/cantarell
xset +fp /usr/share/fonts/wenquanyi
xset +fp /usr/share/fonts/liberation
xset +fp /usr/share/fonts/Twitter Color Emoji

ck-launch-session dbus-launch --sh-syntax --exit-with-session xfce4-session
# exec dwm
