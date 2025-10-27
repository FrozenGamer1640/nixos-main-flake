#!/bin/bash

# ------------------------------------------------------------------------------
# USAGE & HELP
# ------------------------------------------------------------------------------

usage() {
    echo "Use: $0 MODE [OPTIONS]"
    echo
    echo "Modes:"
    echo "  battery     Monitors battery status."
    echo
    echo "Use '$0 MODE -h' to check the usage of a specific mode."
    exit 1
}

usage_battery() {
    echo "Use: $0 battery [-h]"
    echo
    echo "Options:"
    echo "  -h          Shows this message."
    exit 1
}

# ------------------------------------------------------------------------------
# MODE FUNCTIONS
# ------------------------------------------------------------------------------

# --- general ---

handle_invalid_mode() {
    echo "'$1' is not a valid mode." >&2
    usage
}

handle_invalid_option() {
    echo "The option '$1' is not valid for mode '$2" >&2
    usage
}

handle_required_argument() {
    echo "The option '$1' of mode '$2' requires an argument." >&2
    usage
}

# --- battery ---

handle_battery_json() {
    local visible="$1"

    if [ "$visible" = "true" ]; then
        local percent="$2"
        local icon="$3"
        local status="$4"

        jq -n \
            --arg v "true" \
            --arg p "$percent" \
            --arg i "$icon" \
            --arg s "$status" \
            '{visible: $v, percent: $p, icon: $i, status: $s}'
    else
        jq -n --arg v "false" '{visible: $v}'
    fi
}

handle_battery_icon() {
    local -i percent="${1:-0}"
    local -i index
    local -i num_icons

    if (( percent < 0 )); then
        percent=0
    elif (( percent > 100 )); then
        percent=100
    fi

    local ICON_ATLAS=""
    num_icons=${#ICON_ATLAS}

    index=$(( (percent * (num_icons - 1)) / 100 ))
    echo "${ICON_ATLAS:index:1}"
}

handle_battery() {
    while getopts "h" opt; do
        case ${opt} in
            h) usage_battery ;;
            \?) handle_invalid_option "$OPTARG" "battery" ;;
        esac
    done

    local acpi_output="$(acpi -b)"
    local bat_id="$(echo $acpi_output | rg -oP '\w\s\K\d*(?=:)' | head -n 1)"

    if ! [ -s /sys/class/power_supply/BAT${bat_id}/capacity ]; then
        handle_battery_json "false" "" "" ""
        exit 1
    fi

    local bat="/sys/class/power_supply/BAT${bat_id}"

    upower -m | while IFS= read -r LINE; do
        local percent="$(cat "$bat/capacity")"
        local icon="$(handle_battery_icon $percent)"
        local status="$(cat "$bat/status")"

        handle_battery_json "true" "$percent" "$icon" "$status"
    done
    exit 0
}

# ------------------------------------------------------------------------------
# MAIN LOGIC
# ------------------------------------------------------------------------------

MODE=$1
[[ -z "$MODE" ]] && usage
shift

case $MODE in
    battery) handle_battery "$@" ;;
    *) handle_invalid_mode $MODE ;;
esac
