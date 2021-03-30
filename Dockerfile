# FROM ubuntu:latest
FROM nvidia/opencl:runtime-ubuntu18.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt update && apt upgrade -y
RUN apt install wget ocl-icd-opencl-dev -y

RUN mkdir -p /usr/share/doc/fahclient/
ADD config.xml /usr/share/doc/fahclient/sample-config.xml

RUN wget https://download.foldingathome.org/releases/public/release/fahclient/debian-stable-64bit/v7.5/fahclient_7.5.1_amd64.deb && \
    dpkg -i --force-depends fahclient_7.5.1_amd64.deb && \
    rm fahclient*.deb

# EXPOSE 7396 36396

ADD config.xml /etc/fahclient/config.xml

WORKDIR /var/lib/fahclient
CMD ["/usr/bin/FAHClient", \
    "--config", "/etc/fahclient/config.xml", \
    "--config-rotate=false", \
    "--gpu=true", \
    # "--run-as", "fahclient", \
    "--pid-file=/var/run/fahclient.pid"]