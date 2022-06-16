#!/bin/bash
# source: https://stackoverflow.com/questions/26331651/how-can-i-backup-a-docker-container-with-its-data-volumes
# This script allows you to restore a single volume from a container
# Data in restored in volume with same backupped path
NEW_CONTAINER_NAME=$1
BACKAUP_DST=$2
BACKAUP_FILE=$3

usage() {
  echo "Usage: $0 [container name] [BACKUP_SOURCE] ["
  exit 1
}

if [ -z $NEW_CONTAINER_NAME ]
then
  echo "Error: missing container name parameter."
  usage
fi

if [ -z $BACKAUP_DST ]
then
  echo "Error: missing backup destination parameter."
  usage
fi

sudo docker run --rm --volumes-from $NEW_CONTAINER_NAME -v $BACKAUP_DST:/backup busybox tar xvf /backup/$BACKAUP_FILE