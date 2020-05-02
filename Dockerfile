FROM ubuntu
MAINTAINER ivica-matic@outlook.com

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update 
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:ondrej/php 
RUN apt-get update 
RUN apt-get install -y nginx 
RUN apt install -y php7.3 php7.3-fpm
RUN apt-get install -y php7.3-mysqli
	
RUN mkdir apiserver
RUN mkdir apiserver/models
RUN mkdir apiserver/views
RUN mkdir apiserver/credidentials
RUN mkdir apiserver/helpers
COPY models apiserver/models
COPY views apiserver/views
COPY credidentials apiserver/credidentials
COPY helpers apiserver/helpers
COPY index.php apiserver
COPY default /etc/nginx/sites-available

CMD service php7.3-fpm start && nginx -g 'daemon off;'

EXPOSE 80/tcp

