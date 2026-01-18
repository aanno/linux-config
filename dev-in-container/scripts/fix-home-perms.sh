#!/bin/bash -x

IMAGE=$1
TEMP_CONTAINER_NAME=conversion

# Start/fix your container (e.g., with chown inside)
podman run -d --name $TEMP_CONTAINER_NAME --userns=host $IMAGE sleep infinity

# Exec in and fix perms
podman exec -it --user 0 $TEMP_CONTAINER_NAME /bin/sh -c "
  chown -R vscode:vscode /home/vscode &&
  chcon -R -t container_file_t /home/vscode
"

# Commit to new tagged image
podman commit $TEMP_CONTAINER_NAME $IMAGE:fixed

# Test
podman run --rm --userns=host $IMAGE:fixed ls -lZa /home/vscode
echo podman run --rm -it $IMAGE:fixed bash

echo -e "FROM $IMAGE:fixed\nCMD [\"/bin/bash\"]" >Dockerfile
podman build -t $IMAGE:fixed2 .
rm Dockerfile

podman rm -f $TEMP_CONTAINER_NAME
podman rmi $IMAGE $IMAGE:fixed
podman tag $IMAGE:fixed2 $IMAGE:latest
