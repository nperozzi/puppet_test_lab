# Utility Profile
# Utility-specific configuration for nodes
# Currently a marker; will add utility tools/config here

class workshop::profile::utility {
  # Marker file to show this profile was applied
  file { '/opt/workshop/role_marker.txt':
    ensure  => file,
    content => "Role: utility\nApplied at: ${facts['timestamp']}\n",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
}
