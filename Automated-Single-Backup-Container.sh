#!/bin/bash

IMAGE_TAG="9025091158/backup-container:nodejs2-backup-$(date +%Y%m%d%H)"

docker commit NodeJS-2 "$IMAGE_TAG"

docker save "$IMAGE_TAG" > ~/nodejs2-backup-$(date +%Y%m%d%H).tar

docker push "$IMAGE_TAG"

find ~ -name "nodejs2-backup*.tar" -mtime +2 -exec rm -rf {} \;

