FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV NODE_TYPE=master
ENV WORKER_NODE_COUNT=0

RUN apt update && apt install -y \
    openjdk-11-jdk \
    wget \
    iputils-ping \
    sshpass \
    sudo \
    vim \
    openssh-server \
    openssh-client \
    telnet \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

RUN sudo useradd -m -s /bin/bash hadoopuser && echo 'hadoopuser:hadoop' | sudo chpasswd
RUN echo "hadoopuser ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers
USER hadoopuser

RUN sudo wget https://dlcdn.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz
RUN sudo tar -xzf hadoop-3.3.6.tar.gz
RUN sudo mv hadoop-3.3.6 /usr/local/hadoop

COPY ./data /data
RUN sudo chmod 777 /data

# Ports 50470 8020 9000 50075 50475 50010 50020 50090 50070
EXPOSE 22 8088 9870 
CMD ["/bin/bash", "/data/entrypoint.sh"]
