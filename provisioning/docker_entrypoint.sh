#!/bin/bash

#Change permissions of /dev/kvm for Android Emulator
echo "`whoami`" | sudo -S chmod 777 /dev/kvm > /dev/null 2>&1

export PATH=$PATH:/studio-data/platform-tools/

# Default to 'bash' if no arguments are provided
args="$@"
if [ -z "$args" ]; then
  args="~/android-studio/bin/studio.sh"
fi

exec $args
