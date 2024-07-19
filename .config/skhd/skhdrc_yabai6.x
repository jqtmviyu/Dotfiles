# Navigation
alt - h : yabai -m window --focus west
alt - j : yabai -m window --focus south
alt - k : yabai -m window --focus north
alt - l : yabai -m window --focus east

# Moving windows
alt + shift - h : yabai -m window --warp west
alt + shift - j : yabai -m window --warp south
alt + shift - k : yabai -m window --warp north
alt + shift - l : yabai -m window --warp east

# fast focus desktop
alt - n : yabai -m space --focus next
alt + shift - n : yabai -m space --focus prev
alt - r : yabai -m space --focus recent

alt - 1 : yabai -m space --focus 1
alt - 2 : yabai -m space --focus 2
alt - 3 : yabai -m space --focus 3
alt - 4 : yabai -m space --focus 4
alt - 5 : yabai -m space --focus 5
alt - 6 : yabai -m space --focus 6

# send window to space
# alt + shift - 1 : yabai -m window --space 1
# alt + shift - 2 : yabai -m window --space 2
# alt + shift - 3 : yabai -m window --space 3
# alt + shift - 4 : yabai -m window --space 4
# alt + shift - 5 : yabai -m window --space 5
# alt + shift - 6 : yabai -m window --space 6

# Move focus container to workspace
# cmd + shift - n : yabai -m window --space next && yabai -m space --focus next
# cmd + shift - p : yabai -m window --space prev && yabai -m space --focus prev
# cmd + shift - l : yabai -m window --space last && yabai -m space --focus last

alt + shift - 1 : yabai -m window --space 1 && yabai -m space --focus 1
alt + shift - 2 : yabai -m window --space 2 && yabai -m space --focus 2
alt + shift - 3 : yabai -m window --space 3 && yabai -m space --focus 3
alt + shift - 4 : yabai -m window --space 4 && yabai -m space --focus 4
alt + shift - 5 : yabai -m window --space 5 && yabai -m space --focus 5
alt + shift - 6 : yabai -m window --space 6 && yabai -m space --focus 6

# Resize windows
alt + ctrl - h : \
    yabai -m window --resize left:-20:0 ; \
    yabai -m window --resize right:-20:0

alt + ctrl - j : \
    yabai -m window --resize bottom:0:20 ; \
    yabai -m window --resize top:0:20

alt + ctrl - k : \
    yabai -m window --resize top:0:-20 ; \
    yabai -m window --resize bottom:0:-20

alt + ctrl - l : \
    yabai -m window --resize right:20:0 ; \
    yabai -m window --resize left:20:0

# Equalize size of windows
alt + ctrl - 0 : yabai -m space --balance

# Enable / Disable gaps in current workspace
alt + ctrl - g : yabai -m space --toggle padding ; yabai -m space --toggle gap

# Rotate windows clockwise and anticlockwise
alt + ctrl - r : yabai -m space --rotate 90
alt + ctrl - t : yabai -m space --rotate 270

# Rotate on X and Y Axis
alt + ctrl - x : yabai -m space --mirror x-axis
alt + ctrl - y : yabai -m space --mirror y-axis

# Set insertion point for focused container
alt + shift + ctrl - h : yabai -m window --insert west
alt + shift + ctrl - j : yabai -m window --insert south
alt + shift + ctrl - k : yabai -m window --insert north
alt + shift + ctrl - l : yabai -m window --insert east

# Float / Unfloat window
alt - space : yabai -m window --toggle float

# Float and center window
alt - c : isfloat="$(yabai -m query --windows --window | jq --raw-output '.["is-floating"]')" ; \
          $isfloat && yabai -m window --grid 4:4:1:1:2:2 || \
          yabai -m window --toggle float && \
          yabai -m window --grid 4:4:1:1:2:2

# Toggle sticky (show on all spaces)
alt - s : yabai -m window --toggle sticky

# Toggle topmost (keep above other windows)
# version < v6.0.0
# alt - t : yabai -m window --toggle topmost

# version >= v6.0.0
# changer layer (below normal above)
alt - t : layer="$(yabai -m query --windows --window | jq --raw-output '.["sub-layer"]')" && yabai -m window --sub-layer "$([ "$layer" = 'normal' ] && echo 'above' || echo 'normal')"


# Make window native fullscreen
alt - f : yabai -m window --toggle zoom-fullscreen
alt + cmd - f : yabai -m window --toggle native-fullscreen # macos default shortcut

# toggle window split type
alt - g : yabai -m window --toggle split

# create new space
alt + ctrl - n : yabai -m space --create
alt + ctrl - m : yabai -m space --destroy

# Change layout of desktop
alt + ctrl - f : yabai -m space --layout float
alt + ctrl - b : yabai -m space --layout bsp

# destroy empty spaces
alt + ctrl + cmd - w : echo "destroy empty spaces" ; \
                      yabai -m query --spaces \
                      | jq 'reverse | .[] | select((.windows | length) == 0) | .index' \
                      | xargs -I{} yabai -m space {} --destroy

# Restart Yabai
alt + ctrl + cmd - r : osascript <<< \
                      "display notification \"Restarting Yabai\" with title \"Yabai\"" ; \
                      yabai --restart-service

# get window info add quickly add to manageOff list
alt + ctrl - i : json_text=$(yabai -m query --windows --window mouse | jq -r tostring | tr -d '{}"' | tr ',' '\n') ; \
                appName=$(echo "$json_text" | sed -n 's/^app:\(.*\)/\1/p') ; \
                result=$(osascript -e "display dialog \"$json_text\" buttons {\"Close\", \"manageOff\"} default button \"Close\"") ; \
                echo "$result" | grep -q "manageOff" && \
                perl -i -pe "s/manageOffApp\=\'\^\(/manageOffApp\=\'\^\($appName\|/g" ~/.config/yabai/yabairc && \
                yabai --restart-service

# Open app
# alt - return : osascript -e 'tell application "iTerm2" to create window with default profile command ""'
# alt - return : osascript -e 'tell application "iTerm2" to tell current window to create tab with default profile'
alt - return : open -a "kitty"
alt - q : open -a "Google Chrome" && yabai -m space --focus 1
alt - w : open -a "Visual Studio Code" && yabai -m space --focus 2
alt - e : osascript -e 'tell application "System Events" to click UI element "Finder" of list 1 of application process "Dock"'
cmd - space: open -a launchpad
