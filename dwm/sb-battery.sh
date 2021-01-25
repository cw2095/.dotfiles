#!/bin/sh

# Prints all batteries, their percentage remaining and an emoji corresponding
# to charge status ( for plugged up, 🔋 for discharging on battery, etc.).

case $BLOCK_BUTTON in
    3) notify-send " 电源模块" ": 使用电池中
✖: 未找到电池
: 充电中
✔: 已充满
❗: 电量低于20%警告!" ;;
    #4) xbacklight -inc 10 ;;
    #5) xbacklight -dec 10 ;;
    6) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

# if $(acpi -b | grep --quiet 'Battery 0: Unknown')
# then
    # status=;
# else # acpi can give Unknown or Charging if charging, https://unix.stackexchange.com/questions/203741/lenovo-t440s-battery-status-unknown-but-charging
    # status=;
# fi

# capacity=$(cat /sys/class/power_supply/BAT0/capacity)

# [ "$status" = "" ] && [ "$capacity" -le  20 ] && status="❗"

 # echo "$status:$capacity%";

# Loop through all attached batteries.
for battery in /sys/class/power_supply/BAT?
do
    # Get its remaining capacity and charge status.
    capacity=$(cat "$battery"/capacity 2>/dev/null) || break
    status=$(sed "s/[Dd]ischarging//;s/[Nn]ot charging/✖/;s/[Cc]harging//;s/[Uu]nknown/❓/;s/[Ff]ull/✔/" "$battery"/status)

    # If it is discharging and 25% or less, we will add a ❗ as a warning.
     [ "$capacity" -le  20 ] && [ "$status" = "" ] && status="❗"
     # [ "$capacity" -le 25 ] && [ "$status" = "🔋" ] && status="❗" && cvlc --play-and-exit ./low.power.mp3

    printf "%s:%s%%" "$status" "$capacity"
done | sed 's/ *$//'

# get_time_until_charged() {

    # # parses acpitool's battery info for the remaining charge of all batteries and sums them up
    # sum_remaining_charge=$(acpitool -B | grep -E 'Remaining capacity' | awk '{print $4}' | grep -Eo "[0-9]+" | paste -sd+ | bc);

    # # finds the rate at which the batteries being drained at
    # present_rate=$(acpitool -B | grep -E 'Present rate' | awk '{print $4}' | grep -Eo "[0-9]+" | paste -sd+ | bc);

    # # divides current charge by the rate at which it's falling, then converts it into seconds for `date`
    # seconds=$(bc <<< "scale = 10; ($sum_remaining_charge / $present_rate) * 3600");

    # # prettifies the seconds into h:mm:ss format
    # pretty_time=$(date -u -d @${seconds} +%T);

    # echo $pretty_time;
# }

# get_battery_combined_percent() {

    # # get charge of all batteries, combine them
    # total_charge=$(expr $(acpi -b | awk '{print $4}' | grep -Eo "[0-9]+" | paste -sd+ | bc));

    # # get amount of batteries in the device
    # battery_number=$(acpi -b | wc -l);

    # percent=$(expr $total_charge / $battery_number);

    # echo $percent;
# }

# print_bat(){
    # #hash acpi || return 0
    # #onl="$(grep "on-line" <(acpi -V))"
    # #charge="$(awk '{ sum += $1 } END { print sum }' /sys/class/power_supply/BAT*/capacity)%"
    # #if test -z "$onl"
    # #then
        # ## suspend when we close the lid
        # ##systemctl --user stop inhibit-lid-sleep-on-battery.service
        # #echo -e "${charge}"
    # #else
        # ## On mains! no need to suspend
        # ##systemctl --user start inhibit-lid-sleep-on-battery.service
        # #echo -e "${charge}"
    # #fi
    # #echo "$(get_battery_charging_status) $(get_battery_combined_percent)%, $(get_time_until_charged )";
    # echo "$(get_battery_charging_status) $(get_battery_combined_percent)%, $(get_time_until_charged )";
# }
