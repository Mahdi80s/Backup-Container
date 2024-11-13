#!/bin/bash

echo "##################################START#################################"
echo "###############################Mahdi Sardari############################"

CONTAINER_NUMBERS=$(docker ps -a --format "{{.Names}}" | wc -l)

for ((i=1; i<=$CONTAINER_NUMBERS; i++))
do
      CONTAINER=$(docker ps -a --format "{{.Names}}" | sed -n "${i}p")
      IMAGE_TAG="9025091158/backup-container:$CONTAINER-$(date +%Y%m%d%H)"

      docker commit "$CONTAINER" "$IMAGE_TAG"
      docker save "$IMAGE_TAG" > ~/$CONTAINER-backup-$(date +%Y%m%d%H).tar
      docker push "$IMAGE_TAG"

done

find ~ -name "*-backup-*.tar" -mtime +2 -exec rm -rf {} \;
find ~ -name "backup.log" -size +5M -exec rm -rf {} \;

echo "##################################END###################################"
