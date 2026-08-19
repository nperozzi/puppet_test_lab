# Monitoring Profile
# Monitoring-specific configuration for nodes
# Currently a marker; will add monitoring tools/config here

class workshop::profile::monitoring {
  # Marker file to show this profile was applied
  file { '/opt/workshop/role_marker.txt':
    ensure  => file,
    content => "Role: monitoring\nApplied at: ${facts['timestamp']}\n",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
}
