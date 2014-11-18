FROM debian:jessie

# Install RabbitMQ

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y install wget

RUN echo "deb http://www.rabbitmq.com/debian/ testing main" >> /etc/apt/sources.list
RUN cd /tmp && wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc && apt-key add rabbitmq-signing-key-public.asc
RUN apt-get update


RUN apt-get install -y rabbitmq-server pwgen && \
    rabbitmq-plugins enable rabbitmq_management && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add scripts
ADD run.sh /run.sh
ADD set_rabbitmq_password.sh /set_rabbitmq_password.sh
RUN chmod 755 ./*.sh

# change the owner of volume dir
RUN mkdir /data && mkdir /data/mnesia && mkdir /data/log

ENV RABBITMQ_LOG_BASE /data/log
ENV RABBITMQ_MNESIA_BASE /data/mnesia

EXPOSE 5672 15672
VOLUME ["/data/log","/data/mnesia"]


CMD ["/run.sh"]

