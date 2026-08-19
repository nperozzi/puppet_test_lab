#!/bin/bash

set -e

KEY_DIR="/home/puppet/.ssh"
KEY_FILE="$KEY_DIR/id_ed25519"

# If ssh keys do not exist, generate.
if [ ! -f "$KEY_FILE" ]; then
    echo "Generating SSH key..."
    
    ssh-keygen \
        -t ed25519 \
        -N "" \
        -f "$KEY_FILE"

    chown puppet:puppet "$KEY_FILE" "$KEY_FILE.pub"
    chmod 600 "$KEY_FILE"
    chmod 644 "$KEY_FILE.pub"
fi

# Copy publik key to the shared volume
cp "$KEY_FILE.pub" /shared/authorized_key

chown puppet:puppet /shared/authorized_key
chmod 644 /shared/authorized_key

# Initialize known_hosts automaticaly
ssh-keyscan test_node_01 test_node_02 > /home/puppet/.ssh/known_hosts || true

chown puppet:puppet /home/puppet/.ssh/known_hosts
chmod 644 /home/puppet/.ssh/known_hosts

# Start the next command provided by Docker
exec "$@"
