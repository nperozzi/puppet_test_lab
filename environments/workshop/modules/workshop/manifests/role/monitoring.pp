# Monitoring Role
# Nodes with this role monitor the workshop environment

class workshop::role::monitoring {
  # Include baseline configuration (common to all nodes)
  include workshop::profile::baseline

  # Include monitoring-specific configuration
  include workshop::profile::monitoring
}
