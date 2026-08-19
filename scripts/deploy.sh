#!/bin/bash

# Puppet Deployment Script
# Distributes Puppet code to managed nodes and applies configuration
# Usage: ./deploy.sh [node1] [node2] ...
# If no nodes specified, deploys to all known nodes

set -e  # Exit on any error

# Configuration
ENVIRONMENT="workshop"
LOCAL_ENV_PATH="/etc/puppetlabs/code/environments/${ENVIRONMENT}"
REMOTE_ENV_PATH="/etc/puppetlabs/code/environments/${ENVIRONMENT}"
NODES=("node_01" "node_02")

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Helper functions
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if we're running as puppet user
if [ "$(whoami)" != "puppet" ]; then
    log_error "This script must be run as the puppet user"
    exit 1
fi

# Check if local environment exists
if [ ! -d "$LOCAL_ENV_PATH" ]; then
    log_error "Local environment not found at $LOCAL_ENV_PATH"
    exit 1
fi

log_info "Starting Puppet deployment for environment: $ENVIRONMENT"
log_info "Local environment path: $LOCAL_ENV_PATH"

# Deploy to each node
for NODE in "${NODES[@]}"; do
    log_info ""
    log_info "=========================================="
    log_info "Deploying to: $NODE"
    log_info "=========================================="
    
    # Step 1: Copy environment to node
    log_info "Step 1/2: Copying environment to $NODE..."
    if scp -r "$LOCAL_ENV_PATH" "puppet@${NODE}:${REMOTE_ENV_PATH}" > /dev/null 2>&1; then
        log_info "  ✓ Environment copied successfully"
    else
        log_error "Failed to copy environment to $NODE"
        exit 1
    fi
    
    # Step 2: Apply Puppet configuration
    log_info "Step 2/2: Applying Puppet configuration on $NODE..."
    if ssh "puppet@${NODE}" "sudo /opt/puppetlabs/bin/puppet apply --environment=${ENVIRONMENT} ${REMOTE_ENV_PATH}/manifests/site.pp" 2>&1; then
        log_info "  ✓ Puppet apply completed successfully"
    else
        log_error "Puppet apply failed on $NODE"
        exit 1
    fi
done

log_info ""
log_info "=========================================="
log_info "✓ Deployment completed successfully!"
log_info "=========================================="
