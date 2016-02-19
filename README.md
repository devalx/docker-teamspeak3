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

#### Update Notice
I made bigger updates to the Dockerfile to simplify and streamline the whole process. Please read the following infos carefully!

#### Usage v2
I strongly recommend to use a data-container or the new 'docker volume' command in conjunction with this TS3-Container, but its obviously up to you.

##### data container

```
# create the data container
docker run --name=ts3-data --entrypoint /bin/true devalx/docker-teamspeak3:beta
# Now start the actual TS3-Server
docker run --name=ts3 -d --volumes-from ts3-data -p 9987:9987/udp -p 30033:30033 -p 10011:10011devalx/docker-teamspeak3:beta
```

##### docker volume create (Since docker-engine 1.9)
```
docker volume create --name ts3-data
docker run --name=ts3 -p 9987:9987/udp -p 30033:30033 -p 10011:10011 -v ts3-data:/data devalx/docker-teamspeak3:beta
```
	
##### -v 
```
docker run --name TS3 -d -p 9987:9987/udp -p 30033:30033 -p 10011:10011 -v {FOLDER}:/teamspeak3 devalx/docker-teamspeak3:beta
```
   
    
  * Admin Secret
  
    After starting the container you probably want to get the Admin secret with:
    `sudo docker logs TS3` 
    
  * Upgrading
  
    Just stop and remove the old container, then start again at "Creating container". You may have to pull the image again       if its not updating.
    CAUTION: Didnt test if all files are really persisted or if the TS3 process overwrites some files. So make sure you have a backup. 
