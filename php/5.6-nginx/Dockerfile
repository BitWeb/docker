FROM bitweb/php:5.6
MAINTAINER Rain Ramm <rain@bitweb.ee>

RUN apt-get install -y nginx php5.6-fpm
RUN sed -i "s#;cgi.fix_pathinfo=1#cgi.fix_pathinfo=0#g" /etc/php/5.6/fpm/php.ini

CMD ["nginx", "-g", "daemon off;"]
