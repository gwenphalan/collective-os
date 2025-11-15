#!/usr/bin/env bash

set -euo pipefail

regex_escape() {
    # Escape characters that are meaningful to Hyprland's regex-based matcher
    printf '%s' "$1" | sed -e 's/[][(){}.^$|+?*\\]/\\&/g'
}

mapfile -t players < <(playerctl -l 2>/dev/null || true)
[ "${#players[@]}" -gt 0 ] || exit 0

player=""
for candidate in "${players[@]}"; do
    status="$(playerctl --player="${candidate}" status 2>/dev/null || true)"
    if [ "${status}" = "Playing" ]; then
        player="${candidate}"
        break
    fi
done

[ -n "${player}" ] || player="${players[0]}"

player_name="$(playerctl --player="${player}" metadata --format '{{playerName}}' 2>/dev/null || true)"
title="$(playerctl --player="${player}" metadata --format '{{title}}' 2>/dev/null || true)"

# Fully qualified MPRIS bus name (needed for D-Bus lookups)
bus_name="org.mpris.MediaPlayer2.${player}"

# Try to read PID directly from playerctl metadata (works on most players)
pid="$(playerctl --player="${player}" metadata --format '{{mpris:pid}}' 2>/dev/null || true)"

desktop_entry=""
if desktop_entry_output=$(busctl --user get-property "${bus_name}" /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2 DesktopEntry 2>/dev/null); then
    desktop_entry="$(printf '%s' "${desktop_entry_output}" | awk -F"'" 'NR==1 {print $2}')"
fi

if [ -z "${pid}" ]; then
  if pid_output=$(busctl --user call org.freedesktop.DBus /org/freedesktop/DBus org.freedesktop.DBus GetConnectionUnixProcessID s "${bus_name}" 2>/dev/null); then
      pid="$(printf '%s' "${pid_output}" | awk '{print $2}')"
  fi
fi

clients_json="$(hyprctl clients -j 2>/dev/null || true)"
if [ -n "${pid}" ]; then
    if hyprctl dispatch focuswindow "pid:${pid}" >/dev/null 2>&1; then
        exit 0
    fi
fi

if [ -n "${pid}" ] && [ -n "${clients_json}" ]; then
    match_address="$(
        printf '%s' "${clients_json}" | python3 - "${pid}" "${title}" "${desktop_entry}" "${player_name}" <<'PY'
import json
import sys

pid = int(sys.argv[1])
title = sys.argv[2].lower()
desktop = sys.argv[3].lower()
player_name = sys.argv[4].lower()

try:
    clients = json.load(sys.stdin)
except json.JSONDecodeError:
    clients = []

best_addr = ""
best_score = -1

for client in clients:
    if int(client.get("pid", -1)) != pid:
        continue

    score = 1
    cls = client.get("class", "").lower()
    initial_cls = client.get("initialClass", "").lower()
    win_title = client.get("title", "").lower()

    if title and title in win_title:
        score += 6
    if desktop and (desktop in cls or desktop in initial_cls):
        score += 4
    if player_name and (player_name in cls or player_name in initial_cls):
        score += 2

    if score > best_score:
        best_score = score
        best_addr = client.get("address", "")

print(best_addr)
PY
    )"

    if [ -n "${match_address}" ]; then
        if hyprctl dispatch focuswindow "address:${match_address}" >/dev/null 2>&1; then
            exit 0
        fi
    fi
fi

class_hint="${desktop_entry:-${player_name}}"
if [ -n "${class_hint}" ]; then
    escaped_class="$(regex_escape "${class_hint}")"
    if hyprctl dispatch focuswindow "class:^(?i).*${escaped_class}.*$" >/dev/null 2>&1; then
        exit 0
    fi
fi

if [ -n "${player_name}" ]; then
    escaped_player="$(regex_escape "${player_name}")"
    if hyprctl dispatch focuswindow "class:^(?i).*${escaped_player}.*$" >/dev/null 2>&1; then
        exit 0
    fi
fi

if [ -n "${title}" ]; then
    escaped_title="$(regex_escape "${title}")"
    hyprctl dispatch focuswindow "title:^(?i).*${escaped_title}.*$" >/dev/null 2>&1 || true
fi
