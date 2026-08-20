# Puppet Test Lab

A Docker-based Puppet learning environment that demonstrates infrastructure-as-code practices using the Roles and Profiles pattern with Hiera configuration management.

## Overview

This lab simulates a workshop environment with two managed nodes:
- **node_01** (Monitoring role) - Collects system data
- **node_02** (Utility role) - Provides supporting services

All nodes receive a common baseline configuration via Puppet, demonstrating how to manage infrastructure consistently at scale.

## Architecture

**Containers:**
- `puppet_controller` - Puppet server with Hiera data and SSH access
- `test_node_01` - Managed node with Puppet agent (Monitoring role)
- `test_node_02` - Managed node with Puppet agent (Utility role)

**Configuration Pattern:** Roles/Profiles with Hiera data management
- Roles define "what is this machine?"
- Profiles define "how do we configure it?"
- Hiera provides environment-specific configuration values

## Quick Start

### Build and Start

```bash
docker compose down && \
docker compose build --no-cache && \
docker compose up -d
```

### Verify Setup

```bash
# Check that all containers are running
docker compose ps

# Verify the controller can connect to nodes
docker exec puppet_controller ssh test_node_01 hostname
docker exec puppet_controller ssh test_node_02 hostname
```

## Testing

### Test 1: Verify Baseline Configuration

SSH into a managed node and check that baseline packages and configuration are applied:

```bash
# Check that common packages are installed
docker exec test_node_01 which curl git htop

# Check workshop user exists
docker exec test_node_01 id workshop

# Check workshop directories are created
docker exec test_node_01 ls -la /opt/workshop/
docker exec test_node_01 ls -la /etc/workshop/

# Check workshop configuration file
docker exec test_node_01 cat /etc/workshop/workshop.conf
```

### Test 2: Verify Hiera Configuration is Applied

Verify that values from Hiera are correctly rendered in the configuration file:

```bash
# Check workshop configuration contains Hiera values
docker exec test_node_01 grep "WORKSHOP_NAME" /etc/workshop/workshop.conf
docker exec test_node_01 grep "WORKSHOP_LOG_DIR" /etc/workshop/workshop.conf
```

### Test 3: Apply Puppet Changes

Make a change to Hiera data and re-apply Puppet to verify dynamic updates:

```bash
# Edit the common Hiera data
# environments/workshop/data/common.yaml

# Re-run Puppet on a node
docker exec puppet_controller puppet agent -t -h test_node_01

# Verify the change
docker exec test_node_01 cat /etc/workshop/workshop.conf
```

### Test 4: Verify Node-Specific Roles

Check that the roles are properly applied:

```bash
# Check marker files created by monitoring profile
docker exec test_node_01 test -f /opt/workshop/role_marker.txt && echo "node_01 has monitoring profile"

# The utility profile should also exist but may not create visible markers yet
```
