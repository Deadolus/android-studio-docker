#!/bin/bash
# This sript will install our Google Tests on an Android device.
# If needed the script will start an Emulator beforehand.
#It will then run those tests and analyze the results.
#Will return 0 if everything succeeded.
#If there were failed tests it will return the number of failed tests

#Ensure server is started
ADB="/studio-data/Android/Sdk/platform-tools/adb"
"$ADB" start-server || exit 1

if [ "$("$ADB" devices | grep device | wc -l)" -lt 2 ] ; then
    echo "No device found - starting Emulator"
    if [ "$HOSTNAME" = "CI" ]; then
      #Start a virtual framebuffer for continous integration, as we do not have a Display attached
      echo "Starting xvfb for CI..."
      Xvfb :1 &
      export DISPLAY=:1
      #Does not seem to work with GPU, so turn gpu processing off (slower)
      /studio-data/emulator/emulator -avd Nexus_5_API_24 -gpu off > android_emulator_log.txt 2>&1 &
    else
      /studio-data/emulator/emulator -avd Nexus_5_API_24 > android_emulator_log.txt 2>&1 &
fi
    #/studio-data/emulator/emulator -avd Android_O &
    echo "Will now wait for the Emulator"
    #/studio-data/platform-tools/adb wait-for-device -s `/studio-data/platform-tools/adb devices | grep emulator`
    while (! "$ADB" devices | grep emulator | grep device > /dev/null); do sleep 1; echo -n "."; done
fi
device=$("ADB" devices | grep -Po ".*(?= *device$)" | head -n1)
if [ "$device" = "" ]; then
  echo "Error in acquiring device, exiting..."
  exit 1
fi
echo "Found a device \"$device\" to use"

#Install our tests
pushd /studio-data/workspace/GoogleTestApp/
#Build and install our app(s)
./gradlew installDebug || exit 1
#clean, assembleDebug, generateDebugSources
popd
#Clear old logcat data
"$ADB" -s $device logcat -c || exit 1
#(Force-)Start our tests
"$ADB" -s $device shell am start -S -n com.example.company.testApp/com.example.company.testApp.MainActivity

#Wait for the latest adb log data to arrive
while [ $("$ADB" -s $device logcat -d -s "GoogleTest" | grep "End Result" | wc -l) -lt 2 ] ; do
  sleep 0.5
done

#Get our data from logcat and save it
"$ADB" -s $device logcat -d -s "GoogleTest" > test_results.txt || exit 1

#Uninstall our Tests again
pushd /studio-data/workspace/GoogleTestAndroidGnssHal/
./gradlew uninstallDebug || exit 1
popd

#Filter out the failed tests from the log file we pulled
failed_tests=`cat test_results.txt | grep -P -o '\d+(?= Test\(s\) failed --> .*Failed)' | awk 'BEGIN {t=0} {t+=$1} END { print t}'`
if [ "$failed_tests" -gt 0 ]; then
echo "$failed_tests tests failed"
else
echo "All tests passed"
exit 0
fi

"$ADB" -s $device emu kill
while ("$ADB" devices | grep $device > /dev/null) ; do
sleep 0.5
done


exit $failed_tests

