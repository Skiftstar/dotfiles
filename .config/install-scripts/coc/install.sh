#!/bin/bash

EXT_DIR="$HOME/.config/coc/extensions"

cd "$EXT_DIR" || {
  echo "CoC extensions directory not found at $EXT_DIR"
  exit 1
}

echo "Reinstalling CoC extensions..."
npm install
