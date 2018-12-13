FROM ubuntu:latest

RUN apt-get update
RUN apt-get check
RUN apt-get dist-upgrade -y

RUN apt-get install -y apache2

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

ADD apache2.conf /etc/apache2/apache2.conf

EXPOSE 80

ENTRYPOINT ["/usr/sbin/apache2"]
CMD ["-D", "FOREGROUND"]
