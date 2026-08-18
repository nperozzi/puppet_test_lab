FROM ubuntu:24.04

# Installing necessary programs.
RUN apt-get update && \
	apt-get install -y \
		openssh-client \
		git \
		curl \
		sudo \
		ca-certificates && \
	rm -rf /var/lib/apt/lists/*

# Creating puppet user
RUN useradd --create-home --shell /bin/bash puppet

CMD ["sleep", "infinity"]

