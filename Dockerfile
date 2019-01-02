FROM resin/rpi-raspbian:jessie

RUN [ "cross-build-start" ]

RUN apt-get update && apt-get install -y wget apt-transport-https

RUN wget -q -O - http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key | apt-key add -
RUN wget -q -O /etc/apt/sources.list.d/mosquitto-jessie.list http://repo.mosquitto.org/debian/mosquitto-jessie.list
RUN apt-get update && apt-get install -y mosquitto

RUN [ "cross-build-end" ]

VOLUME ["/mqtt/config", "/mqtt/data"]

EXPOSE 1883 8883

CMD /usr/sbin/mosquitto -c /mqtt/config/mosquitto.conf
