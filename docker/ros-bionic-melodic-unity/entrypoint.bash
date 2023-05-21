#! /bin/bash

source /opt/ros/melodic/setup.bash
sudo service dbus start
exec "$@"