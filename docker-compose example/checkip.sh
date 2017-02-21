#!/bin/sh

# Sleep 15 seconds to let the VPN to connect
sleep 15

# Install curl
apk add --no-cache curl

# Display the current IP address
echo "Your IP address from VPN:"
curl -s http://icanhazip.com/

