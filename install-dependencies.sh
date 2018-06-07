
if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
    sudo dpkg --add-architecture i386;
    sudo apt-get update;
    export PKG_CONFIG_PATH=/usr/lib/i386-linux-gnu/pkgconfig/;

    echo "Installing c++ libraries";
    sudo apt-get install libstdc++6:i386;

    echo "Installing GTK-2.0...";
    sudo apt-get install libgtk2.0-0:i386;

    echo "Installing GTK-3.0...";
    sudo apt-get install libgtk-3-0:i386;

    echo "Installing libssl1.0.0...";
    sudo apt-get install libssl1.0.0:i386;

    echo "Installing libGL...";
    sudo apt-get install libglu1-mesa:i386;

fi
