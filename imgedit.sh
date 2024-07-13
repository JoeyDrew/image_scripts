#!/bin/bash

# Check if the first argument (subcommand) is provided
if [ -z "$1" ]; then
  echo "Usage: imgedit <subcommand> [options]"
  exit 1
fi

# Store the subcommand and shift the arguments
subcommand=$1
shift

# Function to add a border to images
add_border() {
  if [ -z "$1" ]; then
    echo "Usage: $0 border <border_size>"
    exit 1
  fi
  
  border_size=$1
  shift
  
  # Enable case-insensitive globbing
  shopt -s nocaseglob
  
  for ext in jpg jpeg png gif; do
    for file in *.$ext; do
      [ -e "$file" ] || continue # Skip if no files match the pattern
      magick convert "$file" -bordercolor white -border ${border_size}x${border_size} "bordered_$file"
    done
  done
  
  # Disable case-insensitive globbing after use
  shopt -u nocaseglob
}

# Handle the subcommand
case $subcommand in
  border)
    add_border "$@"
    ;;
  *)
    echo "Unknown subcommand: $subcommand"
    echo "Available subcommands: border"
    exit 1
    ;;
esac

