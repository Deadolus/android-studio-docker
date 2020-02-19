mkdir -p studio-data/profile/AndroidStudio3.5 || exit
mkdir -p studio-data/Android || exit
mkdir -p studio-data/profile/.android || exit
mkdir -p studio-data/profile/.java || exit
mkdir -p studio-data/profile/.gradle || exit
docker build -t deadolus/android-studio . || exit
