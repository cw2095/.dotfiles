#!/bin/bash
workdir=/home/cw/.config/aria2
cd $workdir

#wget https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_best.txt -O trackers_best.txt > /dev/null 2>&1
curl -d "download=latest" https://torrents.io/tracker-list/ -o trackers_latest.txt -s
tracklist_file=trackers_latest.txt

count=1
if [ -s $tracklist_file ];then
    tracker_str=""
    while read line;do
        if [ ! -z "$line" ];then
            if [ $count -eq 1 ];then
                tracker_str=$tracker_str"$line"
                count=2
            else
                tracker_str="$line,"$tracker_str
            fi
        fi
    done < $tracklist_file
#    echo $tracker_str
fi
#rm -rf trackers_best.txt
sed -i "s|^bt-tracker=.*$|bt-tracker=$tracker_str|" "aria2.conf"
