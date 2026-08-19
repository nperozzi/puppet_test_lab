FROM ubuntu:24.04

ENV PATH="/opt/puppetlabs/bin:${PATH}"

# Installing necessary programs.
RUN apt-get update && \
    apt-get install -y \
        openssh-server \
        sudo \
        ca-certificates \
        wget \
        rsync && \
    rm -rf /var/lib/apt/lists/*

# Installing the Puppet 8 repository.
COPY containers/test_node/puppet8-release-noble.deb /tmp/puppet8-release-noble.deb

RUN dpkg -i /tmp/puppet8-release-noble.deb && \
    rm /tmp/puppet8-release-noble.deb

# Installing Puppet.
RUN apt-get update && \
    apt-get install -y puppet-agent=8.10.0-1noble && \
    rm -rf /var/lib/apt/lists/*

# Creating SSH runtime directory.
RUN mkdir -p /run/sshd

# Create puppet user and give passwordless sudo access
RUN useradd --create-home --shell /bin/bash puppet && \
    usermod -aG sudo puppet && \
    echo "puppet ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/puppet && \
    chmod 440 /etc/sudoers.d/puppet

# Creating SSH directory.
RUN mkdir -p /home/puppet/.ssh && \
    touch /home/puppet/.ssh/authorized_keys && \
    chown -R puppet:puppet /home/puppet/.ssh && \
    chmod 700 /home/puppet/.ssh && \
    chmod 600 /home/puppet/.ssh/authorized_keys

COPY containers/test_node/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/usr/sbin/sshd", "-D"]

