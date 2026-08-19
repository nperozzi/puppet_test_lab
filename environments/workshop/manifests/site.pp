# Puppet Site Manifest
# Entry point for the workshop environment
# Uses node blocks to assign roles to specific nodes

# Node-specific role assignment
node 'node_01' {
  include workshop::role::monitoring
}

node 'node_02' {
  include workshop::role::utility
}

# Fallback for any other nodes
node default {
  include workshop::profile::baseline
}
