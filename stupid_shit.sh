#!/bin/bash

echo "Correct resolution format: <Width>x<Height>, e.g.:"
echo " - 1920x1080 (Full HD)"
echo " - 1280x720 (HD)"
echo " - 2560x1440 (2K)"
echo "No spaces, no uppercase 'X', only whole numbers."

read -p "Enter your username: " USERNAME
read -p "Enter the desired resolution (e.g., 1920x1080): " RESOLUTION

if ! [[ $RESOLUTION =~ ^[0-9]+x[0-9]+$ ]]; then
    echo "Error: Resolution must be in the format <Width>x<Height> (e.g., 1920x1080)."
    exit 1
fi

read -p "Enter the refresh rate (e.g., 75): " REFRESH_RATE

if ! [[ $REFRESH_RATE =~ ^[0-9]+$ ]]; then
    echo "Error: Refresh rate must be an integer (e.g., 75)."
    exit 1
fi

WIDTH=$(echo $RESOLUTION | cut -d'x' -f1)
HEIGHT=$(echo $RESOLUTION | cut -d'x' -f2)

MODELINE=$(cvt $WIDTH $HEIGHT $REFRESH_RATE | grep "Modeline" | cut -d' ' -f2-)
MODE_NAME=$(echo $MODELINE | awk '{print $1}' | tr -d '"')

SCRIPT_PATH="/home/$USERNAME/set-resolution.sh"

cat > $SCRIPT_PATH << EOF
#!/bin/bash
xrandr --newmode $MODELINE
xrandr --addmode DUMMY0 $MODE_NAME
xrandr --output DUMMY0 --mode $MODE_NAME
EOF

chmod +x $SCRIPT_PATH

AUTOSTART_PATH="/home/$USERNAME/.config/autostart"
mkdir -p $AUTOSTART_PATH

cat > $AUTOSTART_PATH/set-resolution.desktop << EOF
[Desktop Entry]
Type=Application
Name=Set Resolution
Exec=$SCRIPT_PATH
X-GNOME-Autostart-enabled=true
EOF

echo "Resolution setup script created and added to autostart."
echo "Script path: $SCRIPT_PATH"
echo "Autostart file: $AUTOSTART_PATH/set-resolution.desktop"
