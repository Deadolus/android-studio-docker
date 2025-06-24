# Android-Studio docker container

Complete Android-Studio in a Docker container.  
You can even start an Emulator inside it.

If you don't have a display the Emulator can run with a "dummy" display — perfect for continuous integration.

Tested on Linux only.

---

## Building without docker compose

Just run:

```bash
./build.sh
```

or:

```bash
docker build -t deadolus/android-studio .
```

An already built version is also on Docker Hub. So you may also run:

```bash
docker pull deadolus/android-studio
```

You may of course change the name of the container.

---

## Running without docker compose

Run:

```bash
HOST_DISPLAY=1 ./run.sh
```

or run directly via:

```bash
docker run -i $AOSP_ARGS -v `pwd`/studio-data:/studio-data --privileged --group-add plugdev deadolus/android-studio
```

`run.sh` has some options which you can set via environment variables:

- `NO_TTY` – Do not run docker with `-t` flag
- `DOCKERHOSTNAME` – Set Docker Hostname. Useful for headless test runs
- `HOST_USB` – Use the USB of the Host (e.g., for physical device access via `adb`)
- `HOST_NET` – Use the network of the host
- `HOST_DISPLAY` – Allow the container to use the host's display (e.g., for running the emulator)

Example usage:

```bash
HOST_NET=1 ./run.sh
```

The default Docker entrypoint tries to start Android Studio.  
So it probably does not make sense to use `run.sh` without:

```bash
HOST_DISPLAY=1
```

If you just want a shell inside the container without starting Android Studio, run:

```bash
./run.sh bash
```

---

## Running and Building with docker compose

1. Comment/uncomment the appropriate lines in the `compose.yaml` depending on whether you're running natively on Linux or in WSL.
2. To build:

    ```bash
    docker compose build android_emulator
    ```

3. To run:

    ```bash
    docker compose run android_emulator
    ```

---

## Additional information – Continuous Integration

A script is included at:

```bash
provisioning/ndkTests.sh
```

This demonstrates how to use this container in a CI environment.

If the `HOSTNAME` variable is set to `CI`, it starts a headless container, then changes into the directory:

```bash
workspace/GoogleTestApp
```

It builds and installs an app, parses `logcat` for lines containing the string `GoogleTest`, uninstalls the app, and analyzes the parsed output.

While this script may not be directly useful for your use case, it serves as a useful guide.

---

## Contributors

- [@Deadolus](https://github.com/Deadolus)
- [@guilhermelinhares](https://github.com/guilhermelinhares)
- [@mtomcanyi](https://github.com/mtomcanyi)
- [@Naveenkhegde](https://github.com/Naveenkhegde)
- [@BenBlumer](https://github.com/BenBlumer)
- [@sulavtimsina](https://github.com/sulavtimsina)
