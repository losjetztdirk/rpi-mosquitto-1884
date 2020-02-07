FROM resin/rpi-raspbian:jessie

RUN apt-get update && apt-get install -y wget apt-transport-https

RUN wget -q -O - http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key | apt-key add -
RUN wget -q -O /etc/apt/sources.list.d/mosquitto-jessie.list http://repo.mosquitto.org/debian/mosquitto-jessie.list
RUN apt-get update && apt-get install -y mosquitto

RUN adduser --system --disabled-password --disabled-login mosquitto

COPY config /mqtt/config
VOLUME ["/mqtt/config", "/mqtt/data"]

EXPOSE 1884 8884

CMD /usr/sbin/mosquitto -c /mqtt/config/mosquitto.conf
