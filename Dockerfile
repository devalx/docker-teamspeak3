FROM ubuntu

# Set some variables.
ENV TEAMSPEAK_URL http://dl.4players.de/ts/releases/3.0.10.3/teamspeak3-server_linux-amd64-3.0.10.3.tar.gz


RUN apt-get update && apt-get install -y curl
RUN cd /opt && curl -sL ${TEAMSPEAK_URL} | tar xz

ENTRYPOINT /opt/teamspeak3-server_linux-amd64/ts3server_minimal_runscript.sh

EXPOSE 9987/udp
