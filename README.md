### docker-teamspeak3

This is a docker container based on ubuntu with installed Teampspeak 3 server.
Just start the container and its ready to go!

#### Summary
* Ubuntu
* Teamspeak 3 server
* Adding a Licence file (planned)


#### Usage

Following commands a just examples which should be ok for most installs.

##### Starting
This starts a docker container in the 
background (-d) with direct mapping of the TS3 port (-p 9987:9987/udp)
and sets the name to TS3.

`sudo docker run --name TS3 -d -p 9987:9987/udp devalx/docker-teamspeak3` 

Logs

Settings
