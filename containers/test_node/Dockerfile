FROM ubuntu:24.04

RUN apt-get update && \
	apt-get install -y \
		openssh-server \
		sudo \
		ca-certificates && \
	rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/sshd

RUN useradd --create-home --shell /bin/bash puppet && \
	usermod -aG sudo puppet

CMD ["/usr/sbin/sshd", "-D"]

