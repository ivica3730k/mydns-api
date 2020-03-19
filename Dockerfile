FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update 
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:ondrej/php 
RUN apt-get update 
RUN apt-get install -y nginx 
RUN apt install -y php7.3 php7.3-fpm
	
RUN mkdir apiserver
RUN mkdir apiserver/models
RUN mkdir apiserver/views
COPY models apiserver/models
COPY views apiserver/views
COPY index.php apiserver
COPY default /etc/nginx/sites-available

CMD service php7.3-fpm start && nginx -g 'daemon off;'

EXPOSE 80/tcp

