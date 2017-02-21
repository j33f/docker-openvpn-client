# Docker container for openvnp client

## Usage 

To run in background simply use the following line below.
You only need to specify:
- your user name
- your password
- the path to a .ovpn configuration file

```
docker run -td -e "USERNAME=your-username-here" -e "PASSWORD=your-password-here" -v /path/to/an/ovnp/file.ovpn:/conf.ovpn --cap-add=NET_ADMIN --device /dev/net/tun --name vpn j33f/openvpn-client
```
