FROM debian:buster

RUN apt-get update \
	&& apt-get upgrade -yq \
	&& apt-get install -y mariadb-server \
	mariadb-client \
	&& apt-get autoclean

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

EXPOSE 3306

WORKDIR /tmp

COPY ./conf/50-server.conf /etc/mysql/mariadb.conf.d

COPY ./tools/script.sh .

ENTRYPOINT [ "./script.sh" ] 

CMD ["mysqld"]

