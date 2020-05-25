#!/usr/bin/env bash

windows_on_curent_space=$(yabai -m query --windows --space)

index_of_focused_window=$(echo "$windows_on_curent_space" | jq ".[].floating" | grep -n 1 | cut -f1 -d:)

application=$(echo "$windows_on_curent_space" | jq -r ".[$((index_of_focused_window-1))].app")

echo "$application"
