ANDROID_GNSS_PATH_DEFAULT="/home/embuser/aosp-docker/_gnss_hal/"
ANDROID_GNSS_PATH=${ANDROID_GNSS_PATH:-$ANDROID_GNSS_PATH_DEFAULT}
AOSP_ARGS=""
if [ "$NO_TTY" = "" ]; then
AOSP_ARGS="${AOSP_ARGS} -t"
fi
if [ "$DOCKERHOSTNAME" != "" ]; then
AOSP_ARGS="${AOSP_ARGS} -h $DOCKERHOSTNAME"
fi
if [ "$HOST_USB" != "" ]; then
AOSP_ARGS="${AOSP_ARGS} -v /dev/bus/usb:/dev/bus/usb"
fi
if [ "$HOST_NET" != "" ]; then
AOSP_ARGS="${AOSP_ARGS} --net=host"
fi
if [ "$HOST_DISPLAY" != "" ]; then
AOSP_ARGS="${AOSP_ARGS} --env=DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix"
fi
#docker run -it --net=host -e DISPLAY=:0 -v /tmp/.X11-unix:/tmp/.X11-unix -v `pwd`/studio-data:/studio-data -v /dev/bus/usb:/dev/bus/usb -v ~/repos/AndroidGnssHal:/AndroidGnssHal --privileged u-blox/android-studio $@
#docker run -it --net=host --env="DISPLAY" -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME/.Xauthority:/home/android/.Xauthority -v `pwd`/studio-data:/studio-data -v /dev/bus/usb:/dev/bus/usb -v ~/aosp-docker/_gnss_hal/:/AndroidGnssHal --privileged u-blox/android-studio $@
#docker run -it --net=host --env="DISPLAY" -v /tmp/.X11-unix:/tmp/.X11-unix -v `pwd`/studio-data:/studio-data -v /dev/bus/usb:/dev/bus/usb -v ~/aosp-docker/_gnss_hal/:/AndroidGnssHal --privileged u-blox/android-studio $@
docker run -i $AOSP_ARGS -v `pwd`/studio-data:/studio-data -v $ANDROID_GNSS_PATH:/AndroidGnssHal --privileged --group-add plugdev -v ~/repos/gps-measurement-tools:/gps u-blox/android-studio $@
