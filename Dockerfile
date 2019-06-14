FROM ubuntu:18.04

ENV TEAMSPEAK_URL http://dl.4players.de/ts/releases/3.8.0/teamspeak3-server_linux_amd64-3.8.0.tar.bz2
ENV TS3_UID 1000

# IMPORTANT! Override TS3SERVER_LICENSE with "accept" to use the Teamspeak 3 server! You can print it with "view" to read

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN apt-get update -q \
  && DEBIAN_FRONTEND=noninteractive apt-get install -qy bzip2 wget \
  && apt-get clean \
  && rm -rf /var/lib/apt \
  && useradd -u ${TS3_UID} ts3 \
  && mkdir -p /home/ts3 \
  && wget -q -O /home/ts3/teamspeak3-server_linux_amd64.tar.bz2 ${TEAMSPEAK_URL} \
  && tar --directory /home/ts3 -xjf /home/ts3/teamspeak3-server_linux_amd64.tar.bz2 \
  && rm /home/ts3/teamspeak3-server_linux_amd64.tar.bz2 \
  && mkdir -p /home/ts3/data/logs \
  && mkdir -p /home/ts3/data/files \
 # && ln -s /home/ts3/data/files /home/ts3/teamspeak3-server_linux_amd64 \
  && ln -s /home/ts3/data/ts3server.sqlitedb /home/ts3/teamspeak3-server_linux_amd64/ts3server.sqlitedb \
  && chown -R ts3 /home/ts3 
# Symlink because i dont know how to move sqlite-db (like dbpath=/data/ts/mysqlite.db)

USER ts3
ENTRYPOINT ["/home/ts3/teamspeak3-server_linux_amd64/ts3server_minimal_runscript.sh"]
CMD ["inifile=/home/ts3/data/ts3server.ini", "logpath=/home/ts3/data/logs","licensepath=/home/ts3/data/","query_ip_whitelist=/home/ts3/data/query_ip_whitelist.txt","query_ip_backlist=/home/ts3/data/query_ip_blacklist.txt"]

VOLUME ["/home/ts3/data"]

# Expose the Standard TS3 port, for files, for serverquery
EXPOSE 9987/udp 30033 10011
