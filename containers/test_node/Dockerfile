FROM ubuntu:24.04

RUN apt-get update && \
	apt-get install -y \
		openssh-server \
		sudo \
		ca-certificates && \
	rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/sshd

# Create puppet user and give passwordless sudo access
RUN useradd --create-home --shell /bin/bash puppet && \
    usermod -aG sudo puppet && \
    echo "puppet ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/puppet && \
    chmod 440 /etc/sudoers.d/puppet

RUN mkdir -p /home/puppet/.ssh && \
    touch /home/puppet/.ssh/authorized_keys && \
    chown -R puppet:puppet /home/puppet/.ssh && \
    chmod 700 /home/puppet/.ssh && \
    chmod 600 /home/puppet/.ssh/authorized_keys

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/usr/sbin/sshd", "-D"]

