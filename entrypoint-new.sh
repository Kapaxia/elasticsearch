#!/bin/sh

# Exit the script as soon as any command fails
set -euo pipefail

# chown the mount to allow the elasticsearch user read and write access
sudo chown -R 1000 /esdata

# exec the original process that the image would have started
exec /bin/tini -- /usr/local/bin/kibana-docker