Android-Studio docker container
============
Complete Android-Studio in a Docker container. 
You can even start an Emulator inside it. 

If you don't have a display the Emulator can run with a "dummy" display - perfect for continous integration.

Tested on Linux only.

Building 
-------------
Just run "./build.sh", or "docker build -t deadolus/android-studio ." directly.
An already built version is also on Docker Hub. So you may also run "docker pull deadolus/android-studio".
You may of course change the name of the container.

Running
-------------
Run "./run.sh" or brun directly via "docker run -i $AOSP_ARGS -v `pwd`/studio-data:/studio-data --privileged --group-add plugdev deadolus/android-studio"


run.sh has some options which you can set via Environment variables. 

* NO_TTY - Do not run docker with -t flag
* DOCKERHOSTNAME - set Docker Hostname. I use it to run tests headless 
* HOST_USB - Use the USB of the Host (useful if you want your physical device to be recognized by adb inside the container)
* HOST_NET - Use the network of the host 
* HOST_DISPLAY - Allow the container to use the Display of the host. E.g. Let the emulator run on the Hosts Display environment.

You may use a Variable like this: "HOST_NET=1 ./run.sh"
