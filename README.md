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
  * ts3server.sqlitedb 
  * licence (Maybe; Dont have one)
  * ts3server.ini (Not tested)

#### Usage
  * Infos
  
	The script does look for an sqlite db in the linked host-folder. 
	If its found, a symlink is created to the ts3-folder inside the container. 
	This means the server should use your old ts3 db if present. 
	If not present it will create a new one, right now this will NOT be created under the linked host-folder!
	The problem here is i cant tell the TS3 server to create the db in specific folder.
	Creating a empty file and then linking this did not work either since TS3 is then complaining its no sqlite db.
	
	Script will also look for ts3server.ini in linked host-folder. This file will also be created if its not 
	found since TS3-server has a paramater for that. If you use your own ini-file you may want to link logs and other data to /teamspeak3.
	This way you can mount the directory and backup/persist the data even when upgrading.
	
	The files-directory is also currently not persisted in the linked host-folder.

  * Build container (optional)
  
	Just in case you dont wanna use the index.
	
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
  
    Just stop and remove the old container, then start again at "Creating container". You may have to pull the image again       if its not updating.
    CAUTION: Didnt test if all files are really persisted or if the TS3 process overwrites some files. So make sure you have a backup. 
