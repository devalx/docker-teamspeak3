FROM ubuntu:16.04

# For the sake of safty, update and validate this hash for each new release!
ENV TEAMSPEAK_URL http://dl.4players.de/ts/releases/3.3.1/teamspeak3-server_linux_amd64-3.3.1.tar.bz2
ENV TEAMSPEAK_SHA256 b3891341a9ff4c4b6b0173ac57f1d64d4752550c95eeb26d2518ac2f5ca9fbc1
ENV TS3_UID 1000

RUN apt-get update -q \
  && DEBIAN_FRONTEND=noninteractive apt-get install -qy bzip2 wget locales \
  && apt-get clean \
  && rm -rf /var/lib/apt \
  && useradd -u ${TS3_UID} ts3 \
  && mkdir -p /home/ts3 \
  && wget -q -O /home/ts3/teamspeak3-server_linux_amd64.tar.bz2 ${TEAMSPEAK_URL} \
  && test ${TEAMSPEAK_SHA256} =  $(sha256sum /home/ts3/teamspeak3-server_linux_amd64.tar.bz2 |awk '{print $1}')\
  && tar --directory /home/ts3 -xjf /home/ts3/teamspeak3-server_linux_amd64.tar.bz2 \
  && rm /home/ts3/teamspeak3-server_linux_amd64.tar.bz2 \
  && mkdir -p /home/ts3/data/logs \
  && mkdir -p /home/ts3/data/files \
 # && ln -s /home/ts3/data/files /home/ts3/teamspeak3-server_linux_amd64 \
  && ln -s /home/ts3/data/ts3server.sqlitedb /home/ts3/teamspeak3-server_linux_amd64/ts3server.sqlitedb \
  && chown -R ts3 /home/ts3 \
  && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
  && touch /home/ts3/.ts3server_license_accepted \
  && locale-gen
# Symlink because i dont know how to move sqlite-db (like dbpath=/data/ts/mysqlite.db)

# Teamspeak 3 expects nowadays an UTF-8 encoding
# Error is:
#  WARNING |ServerLibPriv |   |The system locale is set to "C" this can cause unexpected behavior. We advice you to repair your locale!
# and you'll get runtime errors like this:
#  invalid utf8 string send to logging
# 
# 
# Solution
# Add locales to the docker environment, as suggested in stackoverflow:
# https://stackoverflow.com/a/28406007

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

USER ts3
ENTRYPOINT ["/home/ts3/teamspeak3-server_linux_amd64/ts3server_minimal_runscript.sh"]
CMD ["inifile=/home/ts3/data/ts3server.ini", "logpath=/home/ts3/data/logs","licensepath=/home/ts3/data/","query_ip_whitelist=/home/ts3/data/query_ip_whitelist.txt","query_ip_backlist=/home/ts3/data/query_ip_blacklist.txt", "license_accepted=1"]

VOLUME ["/home/ts3/data"]

# Expose the Standard TS3 port, for files, for serverquery
EXPOSE 9987/udp 30033 10011
