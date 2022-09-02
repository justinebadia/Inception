FROM debian:buster

RUN apt-get update \
	&& apt-get upgrade -yq \
	&& apt-get install -y mariadb-server \
	mariadb-client \
	&& apt-get autoclean

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

EXPOSE 3306

WORKDIR /tmp

COPY ./tools/script.sh .

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

ENTRYPOINT [ "./script.sh" ] 

CMD ["mysqld"]

