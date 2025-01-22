# Use the official ROS Noetic base image
FROM ros:noetic

# Set the maintainer label
LABEL maintainer="saraybakker@gmail.com"

# Set the environment variable for non-interactive mode (to avoid prompts during installation)
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies and utilities
RUN apt-get update && apt-get install -y \
    sudo \
    lsb-release \
    gnupg \
    curl \
    git \
    python3-pip \
    python3-rosdep \
    python3-catkin-tools \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Initialize rosdep
RUN rosdep update

# Set up workspace directory and source ROS environment
RUN mkdir -p /root/catkin_ws/src

# Set the working directory to the ROS workspace
WORKDIR /root/catkin_ws

# Source ROS Noetic setup.bash file and install ROS dependencies
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

# Install ROS dependencies (e.g., rospy, roscpp)
RUN apt-get update && apt-get install -y \
    ros-noetic-desktop-full \
    ros-noetic-rviz \
    ros-noetic-navigation \
    ros-noetic-robot-state-publisher \
    ros-noetic-joy \
    ros-noetic-urdf-tutorial \
    && rm -rf /var/lib/apt/lists/*

# Install additional Python dependencies if needed
RUN pip3 install --no-cache-dir \
    catkin-tools \
    rospkg \
    rosdistro \
    empy
    
RUN git clone --branch 3.4 https://gitlab.com/libeigen/eigen.git /opt/eigen && \
    mkdir /opt/eigen/build && \
    cd /opt/eigen/build && \
    cmake .. && \
    make -j$(nproc) && \
    make install
    
RUN apt update && apt install -y software-properties-common

RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test && \
    apt update && \
    apt install -y gcc-11 g++-11 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 100 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 100

# Set GCC and G++ alternatives
RUN update-alternatives --set gcc /usr/bin/gcc-11 && \
    update-alternatives --set g++ /usr/bin/g++-11
    
# Optional: Remove old GCC versions
RUN apt remove -y gcc-9 g++-9 && apt autoremove -y

# Set the C and C++ compilers for CMake
ENV CC=/usr/bin/gcc
ENV CXX=/usr/bin/g++

# Set up catkin workspace
WORKDIR /root/GAFRO_WS
COPY src /root/GAFRO_WS/src

