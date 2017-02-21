#!/bin/sh

conf="/vpn.conf" auth="/vpn.auth" origconf="/conf.ovpn"

if [ -f "$origconf" ];
then
    if [ -z ${USERNAME+x} ];
    then
        echo "No User name set..."
        exit 1
    else
        if [ -z ${PASSWORD+x} ];
        then
            echo "No password set..."
            exit 1
        else
            cat $origconf > $conf
            echo "auth-user-pass $auth" >> $conf
            echo "$USERNAME" > $auth
            echo "$PASSWORD" >> $auth
            chmod 0600 $auth

            # Launch Openvpn

            openvpn --config $conf
        fi
    fi
else
   echo "Please provide a configuration file"
   exit 0
fi

# if we are here, it is because something wen terribly wrong...
echo "Failed..."
echo "Usage: docker run -ti -e \"USERNAME=your-username-here\" -e \"PASSWORD=your-password-here\" -v /path/to/an/ovnp/file.ovpn:/conf.ovpn --cap-add=NET_ADMIN --device /dev/net/tun --name vpn j33f/openvpn-client"
exit 1