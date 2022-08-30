FROM debian:buster 

RUN apt-get update \
	&& apt-get upgrade -yq \
    && apt-get install -y php-fpm php-common php-mysql mariadb-client \
    && apt-get autoclean

EXPOSE 9000

RUN mkdir -p /var/www /run/php

WORKDIR /var/www

COPY tools/* .

RUN chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

COPY conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

ENTRYPOINT [ "./script.sh" ]

#-F pour force to stay in foreground
#-R pour allow pool to run as root

CMD [ "php-fpm7.3", "-F", "-R"]