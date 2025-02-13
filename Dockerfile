# Default Kibana version to use 
ARG KIBANA_VERSION=8.17.2

# Use the Kibana image with the specified version
FROM kibana:${KIBANA_VERSION}

# Copy in our custom config file that disables the use of nmap
COPY kibana.yml /usr/share/kibana/config/kibana.yml

# Switch to the root user
USER 0

# Install sudo and allow the kibana user to run chown as root
RUN apt-get update && apt-get install -y sudo && \
    echo "kibana ALL=(root) NOPASSWD: /bin/chown" > /etc/sudoers.d/kibana


RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Switch back to the kibana user as kibana can only run as non-root
USER 1000:0

ENTRYPOINT ["/bin/tini", "--"]


CMD ["/usr/local/bin/kibana-docker"]