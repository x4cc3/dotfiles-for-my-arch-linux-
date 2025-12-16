#!/bin/bash

# This script gets the list of open windows and their icons for each workspace.

# Get the list of clients from hyprctl
clients=$(hyprctl clients -j)

# Create an empty JSON object to store the workspace data
workspaces="{}"

# Loop through each client
for client in $(echo "$clients" | jq -c '.[]'); do
  # Get the workspace and window class
  workspace=$(echo "$client" | jq '.workspace.id')
  class=$(echo "$client" | jq -r '.class')

  # Get the icon for the window class
  icon=""
  case "$class" in
    "firefox")
      icon=""
      ;;
    "Thunar")
      icon=""
      ;;
    "ghostty")
      icon="Ghostty"
      ;;
    # Add more cases for other applications here
    *)
      icon=""
      ;;
  esac

  # Add the icon to the workspace
  workspaces=$(echo "$workspaces" | jq -c --arg workspace "$workspace" --arg icon "$icon" '.[$workspace] += $icon')
done

# Print the JSON object
echo "$workspaces"
