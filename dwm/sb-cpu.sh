#!/bin/bash

cpu=`top -b -n1 | fgrep "Cpu(s)" | tail -1 | awk -F'id,' '{split($1, vs, ","); v=vs[length(vs)]; sub(/\s+/, "", v);sub(/\s+/, "", v); printf "%2.2f", 100-v;}'`

temp=$(head -c 2 /sys/class/thermal/thermal_zone0/temp)℃

echo ":$temp ⚙:$cpu%"
