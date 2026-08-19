FROM ubuntu:24.04

# Installing necessary programs.
RUN apt-get update && \
	apt-get install -y \
		openssh-client \
		git \
		curl \
		sudo \
		ca-certificates \
		rsync && \
	rm -rf /var/lib/apt/lists/*

# Creating puppet user
RUN useradd --create-home --shell /bin/bash puppet

# Create SSH keys
## Creating SSH directory.
RUN mkdir -p /home/puppet/.ssh && \
    chown -R puppet:puppet /home/puppet/.ssh && \
    chmod 700 /home/puppet/.ssh

## Transfer the script that generates the keys into the container.
COPY containers/controller/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

## Transfer the deployment script
COPY scripts/deploy.sh /usr/local/bin/deploy.sh

RUN chmod +x /usr/local/bin/deploy.sh

## Run script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["sleep", "infinity"]

