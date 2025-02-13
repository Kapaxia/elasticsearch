#!/bin/sh
set -euo pipefail

# Esperar a Elasticsearch
until curl -sf http://elasticsearch:9200; do
  sleep 5
done

# Configuraciones adicionales (ejemplo)
if [ -n "$KIBANA_DEFAULT_APP" ]; then
  sed -i "s|^#kibana.defaultAppId:.*|kibana.defaultAppId: $KIBANA_DEFAULT_APP|" /usr/share/kibana/config/kibana.yml
fi

# Ejecutar entrypoint original
exec /usr/local/bin/docker-entrypoint.sh kibana
