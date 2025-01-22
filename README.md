# qubes-os-fix-refresh-rate-bash-script
Qubes OS Resolution and Refresh Rate Setup Script

This script automates the process of setting up screen resolution and refresh rate in Qubes OS. It generates a script that uses xrandr to configure the specified resolution and refresh rate on startup, and adds it to the autostart applications.
Features:

    Prompts the user to input their system username, desired screen resolution (in the format <Width>x<Height>), and refresh rate.
    Validates the inputs to ensure the resolution and refresh rate are correctly formatted.
    Generates a new screen mode using cvt and applies it with xrandr.
    Creates a script (set-resolution.sh) to set the resolution and adds it to the autostart directory for automatic execution on system startup.

How to Use:

    Clone the repository or download the script.
    Run the script on your Qubes OS system.
    Enter your username, desired resolution (e.g., 1920x1080), and refresh rate (e.g., 75).
    The script will create a new configuration script and add it to your autostart directory.
    Upon reboot, the resolution and refresh rate will be automatically applied.

Example:

    Resolution: 1920x1080 (Full HD)
    Refresh Rate: 75 Hz
