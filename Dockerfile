FROM osrf/ros:jazzy-desktop-full
ARG USERNAME=student
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ARG CLASS_WS=/class_ws

# Delete user if it exists in container (e.g Ubuntu Noble: ubuntu)
RUN if id -u $USER_UID ; then userdel `id -un $USER_UID` ; fi

# Create the user
RUN groupadd -f --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y python3-pip emacs vim nano
ENV SHELL=/bin/bash

COPY ./src $CLASS_WS/src/class_src

WORKDIR $CLASS_WS

RUN . /opt/ros/jazzy/setup.sh && colcon build --symlink-install

CMD ["/bin/bash"]

######### SOURCES:
# https://docs.ros.org/en/iron/How-To-Guides/Setup-ROS-2-with-VSCode-and-Docker-Container.html