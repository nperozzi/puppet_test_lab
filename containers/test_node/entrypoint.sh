#!/bin/bash

set -e

SSH_DIR="/home/puppet/.ssh"

mkdir -p "$SSH_DIR"

echo "Waiting for controller SSH key..."

while [ ! -f /shared/authorized_key ]; do
    sleep 1
done

cp /shared/authorized_key "$SSH_DIR/authorized_keys"

chown -R puppet:puppet "$SSH_DIR"
chmod 700 "$SSH_DIR"
chmod 600 "$SSH_DIR/authorized_keys"

exec "$@"
