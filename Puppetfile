# Puppetfile
# Declares Puppet module dependencies for the workshop environment
# 
# To install modules defined here, use:
#   puppet module install --modulepath environments/workshop/modules -i Puppetfile
#
# Or manually clone them:
#   cd environments/workshop/modules
#   git clone https://github.com/puppetlabs/puppetlabs-stdlib.git stdlib
#   git clone https://github.com/puppetlabs/puppetlabs-apt.git apt

# Standard Puppet library - required by most modules
mod 'puppetlabs-stdlib',
  :git => 'https://github.com/puppetlabs/puppetlabs-stdlib.git',
  :ref => 'main'

# APT package management for Ubuntu/Debian
mod 'puppetlabs-apt',
  :git => 'https://github.com/puppetlabs/puppetlabs-apt.git',
  :ref => 'main'
