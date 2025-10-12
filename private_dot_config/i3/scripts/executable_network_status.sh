#!/bin/bash

# Check if Wi-Fi connection is available
wifi_status=$(nmcli -t -f active dev wifi | grep 'yes')
if [[ -n "$wifi_status" ]]; then
    # Get Wi-Fi SSID
    wifi_ssid=$(nmcli -t -f ssid dev wifi | head -1)
    icon="󰖩" # Icon for Wi-Fi connection
    network_status="${wifi_ssid#*:}"
else
    # Check if Ethernet connection is available
    ethernet_status=$(nmcli -t -f state dev | grep 'connected')
    if [[ -n "$ethernet_status" ]]; then
        icon="󰈀" # Icon for Ethernet connection
        network_status="Connected"
    else
        icon="󱘖" # Icon for no connection
        network_status="Not Connected"
    fi
fi

# Output network status
echo "$icon "

# Left click opens network configuration menu
case $BLOCK_BUTTON in
    1) nm-connection-editor & ;; 
esac
