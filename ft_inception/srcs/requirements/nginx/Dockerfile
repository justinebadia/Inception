FROM debian:buster

RUN apt-get update \
	&& apt-get upgrade -yq \
    && apt-get install -y nginx \
    && apt-get autoclean

EXPOSE 443

