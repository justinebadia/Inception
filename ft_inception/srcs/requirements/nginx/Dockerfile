FROM debian:buster

RUN apt-get update \
	&& apt-get upgrade -yq \
	&& apt-get install -y nginx \
    && apt-get autoclean

EXPOSE 443

RUN mkdir -p /etc/nginx/ssl

WORKDIR /tmp

COPY tools/* .

COPY conf/* /etc/nginx/ssl

ENTRYPOINT [ "./script.sh" ]

CMD [ "nginx", "-g", "daemon off;" ]

