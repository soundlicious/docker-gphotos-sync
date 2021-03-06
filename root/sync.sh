#!/bin/sh

set -e

echo "INFO: Starting sync.sh PID $$ $(date)"

if [ "$(lsof | grep -c "$0" | tr -d ' ')" -gt 1 ]; then
  echo "WARNING: A previous sync is still running. Skipping new sync command."
else
  echo $$ > /tmp/sync.pid

  echo "INFO: Starting sync!"
  gphotos-cdp -v -dev -headless -dldir /download -run /fix_time.sh

  if [ -z "$CHECK_URL" ]; then
    echo "INFO: Define CHECK_URL with https://healthchecks.io to monitor sync job"
  else
    curl -sS "$CHECK_URL"
  fi

  rm -f /tmp/sync.pid
fi
