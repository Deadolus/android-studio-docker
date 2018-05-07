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

#Make sure prerequisite directories exist in studio-data dir
mkdir -p studio-data/profile/AndroidStudio2.3
mkdir -p studio-data/profile/android
mkdir -p studio-data/profile/gradle
mkdir -p studio-data/profile/java
docker run -i $AOSP_ARGS -v `pwd`/studio-data:/studio-data --privileged --group-add plugdev deadolus/android-studio $@
