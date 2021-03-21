FROM debian:buster

# Set LANG
ENV LANG en_US.utf8

# Install dependencies
RUN apt-get update -y
RUN dpkg --add-architecture i386
RUN apt-get install -y \
    curl \
    wget \
    file \
    tar \
    bzip2 \
    gzip \
    unzip \
    bsdmainutils \
    python \
    util-linux \
    ca-certificates \
    binutils \
    bc \
    jq \
    tmux \
    netcat \
    lib32gcc1 \
    lib32stdc++6 \
    python3 \
    cpio \
    procps

# Get LinuxGSM
RUN wget -O linuxgsm.sh https://linuxgsm.sh

# Setup LinuxGSM user
RUN groupadd -g 750 -o linuxgsm && \
  adduser --uid 750 --disabled-password --gecos "" --ingroup linuxgsm linuxgsm && \
  chown linuxgsm:linuxgsm /linuxgsm.sh && \
  chmod +x /linuxgsm.sh && \
  cp /linuxgsm.sh /home/linuxgsm/linuxgsm.sh && \
  usermod -G tty linuxgsm && \
  chown -R linuxgsm:linuxgsm /home/linuxgsm/ && \
  chmod 755 /home/linuxgsm
USER linuxgsm
ENV PATH=$PATH:/home/linuxgsm
WORKDIR /home/linuxgsm

ENTRYPOINT ["bash"]
