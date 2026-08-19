# Puppet Test Lab

## Background
A small workshop operates several Linux-based devices. These devices perform different functions:
* Monotoring nodes collecting data from equipment.
* Service nodes providing support services.
* All machines need a consistent baseline configuration.

Initially, the machines were configured manually and this has caused problems:
* Different machines have slightly different configs.
* Required packages are, sometimes missing.
* Config files diverge over time.
* Configuring new machines takes a long time.
* Nobody has a reliable description of the desired system state.

The organization wants to use Puppet to describe the desired configuration and automate the configuration and maintainace. 

## Setup description:
The workshop is simulated using Docker. We have two managed machines:
| Node | Role | Purpose |
| --- | --- | --- |
| node_01 | Monotoring | Collect system data |
| node_02 | Utility | Provides supporting tool/services |

## Docker Architecture

This lab consists of three interconnected containers running on a shared bridge network:

- **puppet_controller** — Puppet server managing the test nodes
- **test_node_01** — Test managed node running Puppet agent
- **test_node_02** — Test managed node running Puppet agent

All containers share SSH keys via the `ssh_keys` volume for secure communication.
 
## Puppet Architecture:
                    Git repository
                         │
                         ▼
                puppet_controller
                ┌─────────────────┐
                │ Puppet code     │
                │ Hiera data      │
                │ Git             │
                │ SSH client      │
                └────────┬────────┘
                         │
                    SSH / puppet
                  ┌──────┴──────┐
                  ▼             ▼
          test_node_01    test_node_02
          ┌────────────┐  ┌────────────┐
          │ Puppet     │  │ Puppet     │
          │ Agent      │  │ Agent      │
          │ SSH server │  │ SSH server │
          └────────────┘  └────────────┘

## Puppet structure
                    workshop environment
                            │
                       workshop module
                            │
                 ┌──────────┴──────────┐
                 │                     │
          role::monitoring       role::utility
                 │                     │
          profile::monitoring    profile::utility
                 │                     │
              node_01               node_02

# Rles and Profiles
The role answers "what is this machine?"

The profile answers "how do we configure it?"

* Hiera provides environment-specific data.


* Controller: stores Puppet code, Hiera data, Git, and connects to nodes.
* Nodes: contain the Puppet agent and execute Puppet.
* The controller does not need the Puppet executable.

# Docker commnads:
## Rebuild:
docker compose down && \
docker compose build --no-cache && \
docker compose up -d
