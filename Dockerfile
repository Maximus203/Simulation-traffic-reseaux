FROM ubuntu:latest

RUN apt-get update && apt-get install -y wget cron
COPY download.sh /usr/local/bin/
COPY simple-cron /etc/cron.d/simple-cron
RUN chmod 0644 /etc/cron.d/simple-cron
RUN crontab /etc/cron.d/simple-cron
