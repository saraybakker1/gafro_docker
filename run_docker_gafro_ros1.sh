xhost +local:docker

docker run -it \
   -e "DISPLAY=$DISPLAY" \
   -e "QT_X11_NO_MITSHM=1" \
   -e "NVIDIA_DRIVER_CAPABILITIES=all" \
   --network="host" \
   --privileged \
   -v "/tmp/.X11-unix:/tmp/.X11-unix:rw" \
   --gpus all -t \
   ros-noetic-image:v2 \
   bash
