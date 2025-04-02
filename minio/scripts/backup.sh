#!/bin/sh

echo "Initializing Restic repository if not exists..."
if ! restic snapshots > /dev/null 2>&1; then
  restic init
fi

while true; do
  echo "Starting Restic backup..."
  restic backup /localbackup
  echo "Backup completed. Cleaning up..."
  find /localbackup -type f -delete
  echo "Sleeping for 4 minutes..."
  sleep 240
done
