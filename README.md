### docker-teamspeak3

Ubuntu with TS3 Server.

#### Summary
* Ubuntu
* Teamspeak 3 Server
* Some files can be injected to host:
  * query_ip_whitelist.txt
  * query_ip_blacklist.txt
  * logs
  * files (Not yet)
  * ts3server.sqlitedb (Not yet)
  * licence (Maybe; Dont have one)
  * ts3server.ini (Not tested)

* Usage
  * Build container (optional)
    `sudo docker build https://github.com/devalx/docker-teamspeak3.git` 
  
  * Create container
    
    This creates and starts a docker container in the 
    background (-d) with 
    direct mapping of the TS3 port (-p 9987:9987/udp)
    and sets the name to TS3.
    {FOLDER} is an absolute path on the host to be mapped by the containers /teamspeak3 folder.
    Injected files are used from this location, see Summary above.

    `sudo docker run --name TS3 -d -p 9987:9987/udp -v {FOLDER}:/teamspeak3 devalx/docker-teamspeak3` 
  * Admin Secret
  
    After starting the container you probably want to get the Admin secret with:
    `sudo docker logs TS3` 
    
  * Upgrading
  
    Just stop and remove the old container, then start again at "Creating container". You may have to change the image        if its not updating.
    CAUTION: At the moment this will delete all your configuration and will give you a fresh install. 
