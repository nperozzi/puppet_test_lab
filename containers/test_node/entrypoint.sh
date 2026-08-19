#!/bin/bash

set -e

SSH_DIR="/home/puppet/.ssh"
PUPPET_ENV_DIR="/etc/puppetlabs/code/environments"

# Create necessary directories
mkdir -p "$SSH_DIR"
mkdir -p "$PUPPET_ENV_DIR"

# Ensure puppet user owns the directories
chown puppet:puppet "$PUPPET_ENV_DIR"

echo "Waiting for controller SSH key..."

while [ ! -f /shared/authorized_key ]; do
    sleep 1
done

cp /shared/authorized_key "$SSH_DIR/authorized_keys"

chown -R puppet:puppet "$SSH_DIR"
chmod 700 "$SSH_DIR"
chmod 600 "$SSH_DIR/authorized_keys"

exec "$@"
