#!/bin/bash
# source: https://stackoverflow.com/questions/26331651/how-can-i-backup-a-docker-container-with-its-data-volumes
# This script allows you to backup a single volume from a container
# Data in given volume is saved in the current directory in a tar archive.
CONTAINER_NAME=$1
VOLUME_NAME=$2
DESTINATION=$3
NAME=$4

DATE=$(date +"%Y-%m-%d_%H-%M-%S")

usage() {
  echo "Usage: $0 [container name] [volume name] [backup destination]"
  exit 1
}

if [ -z $CONTAINER_NAME ]
then
  echo "Error: missing container name parameter."
  usage
fi

if [ -z $VOLUME_NAME ]
then
  echo "Error: missing volume name parameter."
  usage
fi

if [ -z $DESTINATION ]
then
  echo "Error: missing destination parameter."
  usage
fi

if [ -z $NAME ]
then
  echo "No Name given, using backup"
  NAME="backup"
fi

sudo docker run --rm --volumes-from $CONTAINER_NAME -v $DESTINATION:/backup busybox tar cvzf /backup/${NAME}_${DATE}.tar.gz $VOLUME_NAME