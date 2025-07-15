# Discord Auto Update Thingie

Set up .desktop entry for gnome
```
chmod u+x DAUT-install.sh
./DAUT-install.sh
```
run manually with
```
./DAUT-start.sh
```
## Wat doing?

Script checks for updates and starts discord. A loop script is also started that checks for updates every hour. When update is detected it asks if user wants to install the update and then does the thingie.

### Works yes?

Maybe.. Tested on debian + gnome. 

Might be a bit yanky since I had no idea what I was doing but works better than no update checking at all...
