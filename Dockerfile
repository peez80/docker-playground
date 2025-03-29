FROM ubuntu:noble
LABEL maintainer="peez@stiffi.de"

RUN apt-get update && apt-get install -y \
    openssl \
    openjdk-8-jdk \
    iputils-ping \
    vim \
    less \
    curl \
    apache2-utils \
    net-tools \
    jhead \
    traceroute \
    openssh-client \
    socat \
    apt-transport-https \
    tcpdump \
    connect-proxy \
    dnsutils \
    gnupg \
    telnet \
    imagemagick \
    unzip \
    jq \
    ncdu \
    wget \
    iperf3 \
    mosquitto-clients \
    par2 \
    && apt-get autoremove && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

#For Scanning via Smarthome
RUN apt-get update && apt-get install -y img2pdf icc-profiles-free \
    && apt-get autoremove && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
    
RUN apt-get update && apt-get install -y figlet toilet \
    && apt-get autoremove && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/borgbackup/borg/releases/download/1.4.0/borg-linux-glibc236 \
    && mv borg-linux-glibc236 /usr/local/bin/borg \
    && chmod 755 /usr/local/bin/borg \
    && ln -s /usr/local/bin/borg /usr/local/bin/borgfs


# Install aws-cli
RUN curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm awscliv2.zip


# INstall kubectl
#RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
#    && touch /etc/apt/sources.list.d/kubernetes.list \
#    && echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list \
#    && apt-get update \
#    && apt-get install -y kubectl \
#    && apt-get autoremove && apt-get clean \
#    && rm -rf /var/lib/apt/lists/*







COPY scripts/ /scripts/
RUN chmod -R +x /scripts/*
