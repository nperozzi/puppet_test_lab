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

# Initialize known_hosts automatically
# Scan each node with retries to handle timing issues during startup
> /home/puppet/.ssh/known_hosts

for node in node_01 node_02; do
    echo "Scanning host keys for $node..."
    for attempt in {1..10}; do
        if ssh-keyscan -T 2 "$node" >> /home/puppet/.ssh/known_hosts 2>/dev/null; then
            echo "  ✓ $node host key obtained"
            break
        else
            if [ $attempt -eq 10 ]; then
                echo "  ✗ Failed to get host key for $node after 10 attempts"
            else
                sleep 1
            fi
        fi
    done
done

chown puppet:puppet /home/puppet/.ssh/known_hosts
chmod 644 /home/puppet/.ssh/known_hosts

# Start the next command provided by Docker
exec "$@"
