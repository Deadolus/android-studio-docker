#!/bin/bash

#Change permissions of /dev/kvm for Android Emulator
echo "`whoami`" | sudo -S chmod 777 /dev/kvm > /dev/null 2>&1

export PATH=$PATH:/studio-data/platform-tools/

# Ensure the Android directory exists and has the correct permissions
if [ ! -d "/studio-data/Android" ]; then
  mkdir -p /studio-data/Android
fi
sudo chown -R android:android /studio-data/Android

# Default to 'bash' if no arguments are provided
args="$@"
if [ -z "$args" ]; then
  args="~/android-studio/bin/studio.sh"
fi

exec $args
