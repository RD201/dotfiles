#!/bin/bash

# Get battery status
battery_info=$(acpi -b)
battery_status=$(echo "$battery_info" | awk '{print $3}' | tr -d ',')

# Get battery charge level
battery_charge=$(echo "$battery_info" | awk '{print $4}' | tr -d '%,')


# Determine battery state (low, medium, high)
battery_state=""
if [ "$battery_charge" -lt 20 ]; then
    battery_state="󱊡"
elif [ "$battery_charge" -lt 50 ]; then
    battery_state="󱊢"
else
    battery_state="󱊣"
fi

# Determine charging status
charging_status=$(echo "$battery_info" | grep -c "Charging")

# Output battery status with appropriate icon
case $charging_status in
    1) icon="()" ;; # Battery is charging
    *) icon= ""
esac

case $battery_charge in
    "charging") battery_charge="100" ;; 
esac

echo "$battery_state $battery_charge%$icon"

