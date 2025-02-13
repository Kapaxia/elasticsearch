#!/bin/sh

# Wait for Elasticsearch to start up before starting Kibana.
until curl -sf http://elasticsearch:9200; do
  sleep 5
done

# Additional configurations (example)
if [ -n "$KIBANA_DEFAULT_APP" ]; then
  sed -i "s|^#kibana.defaultAppId:.*|kibana.defaultAppId: $KIBANA_DEFAULT_APP|" /usr/share/kibana/config/kibana.yml
fi

# Execute the original entrypoint
exec kibana /bin/bash
