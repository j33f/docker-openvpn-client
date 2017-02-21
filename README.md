# Docker container for openvnp client

## Usage 

To run in background simply use the following line below.
You only need to specify:
- your user name
- your password
- the path to a .ovpn configuration file

/!\ this is a minimal configuration line. See the docker-compose usage

```
docker run -td -e "USERNAME=your-username-here" -e "PASSWORD=your-password-here" -v /path/to/an/ovnp/file.ovpn:/conf.ovpn --cap-add=NET_ADMIN --device /dev/net/tun --name vpn j33f/openvpn-client
```

replace the ```-td``` option with ```-ti``` if you want to test if everything is good.

## Usage with docker-compose

The aim for this container is to provide an OpenVPN connexion for other containers.
Using a docker-compose file will simplify this process. Here is an example:

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
      - USERNAME=your-username-here
      - PASSWORD=your-password-here
```