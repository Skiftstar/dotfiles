
#!/bin/bash

filename="$HOME/Pictures/Screenshots/Screenshot-$(date +%F_%T).png"
grim -g "$(slurp)" - | wl-copy && wl-paste > "$filename" && dunstify -i "$filename" "Screenshot of the region taken" -t 1000
