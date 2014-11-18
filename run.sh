#!/bin/bash
if [ ! -f /.rabbitmq_password_set ]; then
	/set_rabbitmq_password.sh
fi

chown -R rabbitmq:rabbitmq /data/log
chown -R rabbitmq:rabbitmq /data/mnesia

exec /usr/sbin/rabbitmq-server
