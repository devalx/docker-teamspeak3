FROM ubuntu:15.10

MAINTAINER alex.devalx@gmail.com

ENV TEAMSPEAK_URL http://dl.4players.de/ts/releases/3.0.12.2/teamspeak3-server_linux_amd64-3.0.12.2.tar.bz2
ENV TS3_UID 1000
RUN apt-get update -q \
  && DEBIAN_FRONTEND=noninteractive apt-get install -qy bzip2 \
  && apt-get clean \
  && rm -rf /var/lib/apt

ADD ${TEAMSPEAK_URL} /home/ts3/

RUN useradd -u ${TS3_UID} ts3 \
  && tar --directory /home/ts3 -xjf /home/ts3/teamspeak3-server_linux_amd64-3*.tar.bz2 \
  && mkdir -p /data/ts3/logs \
  && mkdir -p /data/ts3/files \
  && chown -R ts3 /data \
  && ln -s /data/ts3/ts3server.sqlitedb /home/ts3/teamspeak3-server_linux_amd64/ts3server.sqlitedb
# Symlink because i dont know how to move sqlite-db (like dbpath=/data/ts/mysqlite.db)

USER ts3
ENTRYPOINT ["/home/ts3/teamspeak3-server_linux_amd64/ts3server_minimal_runscript.sh"]
CMD ["inifile=/data/ts3/ts3server.ini", "logpath=/data/ts3/logs","licensepath=/data/ts3/","query_ip_whitelist=/data/ts3/query_ip_whitelist.txt","query_ip_backlist=/data/ts3/query_ip_blacklist.txt"]

VOLUME ["/data/ts3"]

# Expose the Standard TS3 port, for files, for serverquery
EXPOSE 9987/udp 30033 10011
