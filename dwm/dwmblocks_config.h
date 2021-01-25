//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
    /*Icon*/    /*Command*/                                         /*Update Interval*/    /*Update Signal*/
    /* {"⌨", "sb-kbselect", 0, 30}, */
    {"",      "cat /tmp/recordingicon 2>/dev/null",                  0,                    9},
    // {"",      "/bin/bash /home/cw/.dotfiles/dwm/sb-weather.sh",   18000,                9},
    {"",      "/bin/bash /home/cw/.dotfiles/dwm/sb-nettraf.sh",      1,                    26},
    {"",      "/bin/bash /home/cw/.dotfiles/dwm/sb-internet.sh",     5,                    25},
    {"",      "/bin/bash /home/cw/.dotfiles/dwm/sb-cpu.sh",          5,                    24},
    {"",      "/bin/bash /home/cw/.dotfiles/dwm/sb-mem.sh",          5,                    23},
    {"",      "/bin/bash /home/cw/.dotfiles/dwm/sb-volume.sh",       0,                    22},
    {"",      "/bin/bash /home/cw/.dotfiles/dwm/sb-light.sh",        0,                    21},
    {"",      "/bin/bash /home/cw/.dotfiles/dwm/sb-battery.sh",      10,                   20},
    {"",      "/bin/bash /home/cw/.dotfiles/dwm/sb-clock.sh",        60,                   9},
};

//Sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char *delim = " ";

// Have dwmblocks automatically recompile and run when you edit this file in
// vim with the following line in your vimrc/init.vim:

// autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & }
