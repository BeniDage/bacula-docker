#!/bin/sh

echo "Setting up MinIO..."
mc alias set myminio http://minioserver:9000 adminuser adminpassword

if ! mc ls myminio/restic-backups > /dev/null 2>&1; then
  echo "Creating MinIO bucket..."
  mc mb myminio/restic-backups
fi

echo "Ensuring /localbackup folder exists..."
mkdir -p /localbackup

echo "Starting MinIO mirroring..."
while true; do
  echo "Mirroring MinIO bucket to local directory..."
  mc mirror --overwrite myminio/restic-backups /localbackup
  echo "Mirror completed. Sleeping for 2.5 minutes..."
  sleep 150
done
