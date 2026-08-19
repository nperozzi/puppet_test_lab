# Baseline Configuration
# Applied to all workshop nodes

class workshop::baseline {
  # Include the puppetlabs-apt module for package management
  include apt

  # Common packages for all nodes
  package { ['curl', 'git', 'htop']:
    ensure  => present,
    require => Class['apt'],
  }

  # Workshop system user
  user { 'workshop':
    ensure           => present,
    home             => '/home/workshop',
    shell            => '/bin/bash',
    managehome       => true,
    comment          => 'Workshop system user',
  }

  # Workshop base directory structure
  file { '/opt/workshop':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { '/opt/workshop/logs':
    ensure  => directory,
    owner   => 'workshop',
    group   => 'workshop',
    mode    => '0755',
    require => [
      File['/opt/workshop'],
      User['workshop'],
    ],
  }

  # Workshop configuration directory
  file { '/etc/workshop':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  # Workshop configuration file
  file { '/etc/workshop/workshop.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File['/etc/workshop'],
  }

  # Ensure rsyslog package is installed
  package { 'rsyslog':
    ensure  => present,
    require => Class['apt'],
  }
}
