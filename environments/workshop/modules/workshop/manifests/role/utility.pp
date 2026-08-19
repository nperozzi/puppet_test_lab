# Utility Role
# Nodes with this role provide utility services to the workshop environment

class workshop::role::utility {
  # Include baseline configuration (common to all nodes)
  include workshop::profile::baseline

  # Include utility-specific configuration
  include workshop::profile::utility
}
