# Docker container for openvnp client

## Usage 

To run in background simply use the following oneliner below.
You only need to specify:
- your user name
- your password
- the path to a .ovpn configuration file

/!\ this is a minimal configuration line. See the docker-compose usage

```
docker run -td -e "OVPNUSERNAME=your-username-here" -e "OVPNPASSWORD=your-password-here" -v /path/to/an/ovnp/file.ovpn:/conf.ovpn --cap-add=NET_ADMIN --device /dev/net/tun --name vpn j33f/openvpn-client
```

replace the ```-td``` option with ```-ti``` if you want to test if everything is good.

## Usage with docker-compose

This container aims to provide an OpenVPN connexion for other containers.
Using a docker-compose file will simplify this process. 
For more details, see the [docker-compose example](./docker-compose%20example) folder
Here is an example:

```
version: "2"

services:
  vpn:
    image: j33f/openvpn-client
    container_name: vpn
    privileged: true
    restart: always
    cap_add:
      - NET_ADMIN
    devices:
      - /dev/net/tun
    dns:
      - 8.8.8.8
      - 8.8.4.4
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /path/to/an/ovnp/file.ovpn:/conf.ovpn
    environment:
      - OVPNUSERNAME=your-username-here
      - OVPNPASSWORD=your-password-here

  checkip:                         # this is the VPN dependant container
    image: alpine:latest
    container_name: checkip         
    volumes:
      - ./checkip.sh:/checkip.sh   # this is the script that will be launched
    depends_on:
      - vpn                        # /!\ this is needed so that the vpn container launch first
    network_mode: container:vpn    # /!\ imporant: this will make this container to use the vpn for internet traffic
    command: chmod a+x /checkip.sh
    entrypoint: /checkip.sh
```
