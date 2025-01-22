To build the ROS1-docker container:
```bash
  chmod +x ./install_src_repos.sh
  ./install_src_repos.sh                  # creates src folder and downloads repos from gitlab
  docker build -t ros-noetic-image:v2 .
```

To start the docker container:
```bash
chmod +x ./run_docker_gafro_ros1.sh
./run_docker_gafro_ros1.sh 
```
