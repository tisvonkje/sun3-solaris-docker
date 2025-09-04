Goal
----
This project enables you to run a Solaris Sun3 machine using the tme emulator in a docker container.

Acknowledgements
----------------
The major contributions to this achievement are those of the [tme project](https://people.csail.mit.edu/fredette/tme/) and [phabrics](https://github.com/phabrics/Run-Sun3-SunOS-4.1.1) who gathered the files needed for running Solaris.
My only contribution is putting the stuff together and configuring the right (ancient) ubuntu release and libraries.

Building instructions
---------------------
Start with cloning this repository:

```
git clone https://github.com/tisvonkje/sun3-solaris-docker
cd sun3-solaris-docker
```

Now build the image:
```
sudo docker build -t sun3 .
```
Under MacOS with apple hardware you need to specify the platform:
```
sudo docker build --platform linux/amd64 -t sun3 .
```
Relax, this may take a while. After successful creation we can run the container. Since the tme emulates the Sun's graphical screen, we have to set up some stuff to run
an X11 application from within the container.

Running on Linux
----------------
First determine if you have a proper X11 setup, run the following command:
```
xauth info
```
This will describe the X11 authorization file. Write down (or copy) its full filename, for me it is ```/run/user/100/gdm/Xauthority``` (the exact name may differ for you).
Now run the container using:
```
sudo docker run --net=host --env DISPLAY=$DISPLAY --env XAUTHORITY=/root/xxx --volume="/tmp/.X11-unix:/tmp/.X11-unix" --volume="/run/user/100/gdm/Xauthority:/root/xxx:ro" -it sun3 /bin/bash
```
Of course replace ```/run/user/100/gdm/Xauthority``` with your personal file name.
Once inside the container, fire up the emulator using:
```
./run_tme SUN3
````

Running on MacOS
----------------
For MacOS you first need to install [XQuartz](https://www.xquartz.org) if you do not have it already (this may involve a reboot). Run XQuartz and go to the settings menu item. Under the security tab check 'Allow connections from network clients'.
Now quit XQuartz and start it up again.
To allow connections from inside the container run:
```
xhost +localhost
```
And run the container using:
```
docker run -e DISPLAY=host.docker.internal:0 -it sun3 /bin/bash
```
Once inside the container, fire up the emulator using:
```
./run_tme SUN3
````

Installing Solaris yourself
---------------------------
The docker image comes with a preinstalled Solaris version. If you want want to create it yourself (from the boot tape) follow the instructions [here](https://github.com/phabrics/Run-Sun3-SunOS-4.1.1)
