## (This image is forked from  tutum/rabbitmq but modified the base image with debian:jessie and export the "mnesia" and "log" dirs)


tutum-docker-rabbitmq
=====================

Base docker image to run a RabbitMQ server


Usage
-----

To create the image `c3h3/rabbitmq`, execute the following command on the tutum-rabbitmq folder:

	sudo docker build -t c3h3/rabbitmq .


Running the RabbitMQ server
---------------------------

Run the following command to start rabbitmq:

	docker run -d -p 5672:5672 -p 15672:15672 c3h3/rabbitmq

The first time that you run your container, a new random password will be set.
To get the password, check the logs of the container by running:

	docker logs <CONTAINER_ID>

You will see an output like the following:

	========================================================================
	You can now connect to this RabbitMQ server using, for example:

            curl --user admin:5elsT6KtjrqV  http://<host>:<port>/api/vhosts

	Please remember to change the above password as soon as possible!
	========================================================================

In this case, `5elsT6KtjrqV` is the password set. 
You can then connect to RabbitMQ:

        curl --user admin:5elsT6KtjrqV  http://<host>:<port>/api/vhosts

Done!


Setting a specific password for the admin account
-------------------------------------------------

If you want to use a preset password instead of a randomly generated one, you can
set the environment variable `RABBITMQ_PASS` to your specific password when running the container:

	docker run -d -p 5672:5672 -p 15672:15672 -e RABBITMQ_PASS="mypass" c3h3/rabbitmq

You can now test your new admin password:

        curl --user admin:mypass  http://<host>:<port>/api/vhosts


Mount with outside mnesia and log directories
-------------------------------------------------

If you want to use outside "mnesia" and "log" directories, you could use the following command:
	
	mkdir -p mnesia
	mkdir -p log
    docker run -d -p 5672:5672 -p 15672:15672 -v $PWD/mnesia:/data/mnesia -v $PWD/log:/data/log c3h3/rabbitmq


