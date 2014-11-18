#!/bin/bash
if [ ! -f /.rabbitmq_password_set ]; then
	/set_rabbitmq_password.sh
fi

chown -R rabbitmq:rabbitmq $RABBITMQ_LOG_BASE
chown -R rabbitmq:rabbitmq $RABBITMQ_MNESIA

exec /usr/sbin/rabbitmq-server
