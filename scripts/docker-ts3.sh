#!/bin/bash

VOLUME=/teamspeak3/

#-- ts 3 starten im hintergrund
#-- den erstellten files ordner symlinken
#-- die erstelle ts3 db symlinken

echo "This scripts checks the existence of the ts3server.sqlitedb."
echo "Checking..."
if [ -f $VOLUME/ts3server.sqlitedb ]
  then
    echo "$VOLUME/ts3server.sqlitedb exists."
	echo "Creating link."
	ln -s $VOLUME/ts3server.sqlitedb /opt/teamspeak3-server_linux-amd64/ts3server.sqlitedb 
fi


/opt/teamspeak3-server_linux-amd64/ts3server_minimal_runscript.sh \
  query_ip_whitelist="/teamspeak3/query_ip_whitelist.txt" \
  query_ip_backlist="/teamspeak3/query_ip_blacklist.txt" \
  logpath="/teamspeak3/logs/" \
  licensepath="/teamspeak3/" 
#  inifile="/teamspeak3/ts3server.ini" \
#  createinifile=1 

#ln -s /opt/teamspeak3-server_linux-amd64/files/ /teamspeak3/files/

