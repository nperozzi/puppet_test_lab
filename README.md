# Puppet Test Lab

## Docker Architecture

This lab consists of three interconnected containers running on a shared bridge network:

- **puppet_controller** — Puppet server managing the test nodes
- **test_node_01** — Test managed node running Puppet agent
- **test_node_02** — Test managed node running Puppet agent

All containers share SSH keys via the `ssh_keys` volume for secure communication.
