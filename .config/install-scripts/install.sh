#!/bin/bash

# List folders to exclude from the install process
EXCLUDE=("firefox-theme") 

is_excluded() {
  local target="$1"
  for item in "${EXCLUDE[@]}"; do
    [[ "$item" == "$target" ]] && return 0
  done
  return 1
}

# Loop through all subdirectories
for dir in */; do
  dir="${dir%/}"  # Remove trailing slash

  if is_excluded "$dir"; then
    echo "🚫 Skipping $dir (excluded)"
    continue
  fi

  script="./$dir/install.sh"

  if [[ -f "$script" ]]; then
    echo "🔧 Running install in $dir"
    chmod +x "$script"
    "$script"
  else
    echo "⚠️ No install.sh found in $dir"
  fi
done
