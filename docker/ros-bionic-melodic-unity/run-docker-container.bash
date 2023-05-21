#!/bin/bash

# get parameter from system
user=`id -un`

# start sharing xhost
xhost +local:root

# run docker
docker run --rm \
  --net=host \
  --ipc=host \
  --gpus all \
  --privileged \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -v $HOME/.Xauthority:$docker/.Xauthority \
  -v $HOME/work:$HOME/work \
  -e XAUTHORITY=$home_folder/.Xauthority \
  -e DISPLAY=$DISPLAY \
  -e QT_X11_NO_MITSHM=1 \
  -dit --name "ros-melodic-unity" ${user}/ros-bionic-melodic-unity

#   # 追記↓（-v /var/run/dbus:/var/run/dbus \と合わせて）
# sudo dbus-daemon --system --fork
# sudo systemctl start dbus.service
# sudo mkdir -p /var/run/dbus
# sudo dbus-uuidgen --ensure=/var/run/dbus/system_bus_socket
# sudo chown messagebus:messagebus /var/run/dbus/system_bus_socket
# # 追記↑-------------------------------------------------
#   -e DBUS_SESSION_BUS_ADDRESS=unix:path=$XDG_RUNTIME_DIR/bus \
#   -e export LIBVA_DRIVER_NAME=iHD \
#   -e ./Anytype-0.18.28.AppImage --no-sandbox \

#   # ERROR:bus.cc(398)] Failed to connect to the bus: Failed to connect to socket /var/run/dbus/system_bus_socket
#   # ERROR:bus.cc(398)] Failed to connect to the bus: Could not parse server address: Unknown address type (examples of valid types are "tcp" and on UNIX "unix")
#   # https://github.com/microsoft/WSL/issues/7915
#   # https://blog.n-z.jp/blog/2020-06-02-systemd-user-bus.html
# - export DISPLAY=172.19.48.1:0
# - sudo service dbus start
# - export XDG_RUNTIME_DIR=/run/user/$(id -u)
# - sudo mkdir $XDG_RUNTIME_USER
# - sudo chmod 700 $XDG_RUNTIME_DIR
# - sudo chown $(id -un):$(id -gn) $XDG_RUNTIME_DIR
# - export DBUS_SESSION_BUS_ADDRESS=unix:path=$XDG_RUNTIME_DIR/bus
# - dbus-daemon --session --address=$DBUS_SESSION_BUS_ADDRESS --nofork --nopidfile --syslog-only &
# # Clibva error: va_getDriverName() failed with unknown libva error,driver_name=(null)
# # https://community.anytype.io/t/solve-libva-error-va-getdrivername-failed-with-unknown-libva-error/1368

# # ERROR:viz_main_impl.cc(186)] Exiting GPU process due to errors during initialization
# # https://www.bigbang.mydns.jp/browser-x.htm