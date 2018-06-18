# OpenVPN for Docker

[![Build Status](https://travis-ci.org/marcodangelo/docker-openvpn.svg)](https://travis-ci.org/marcodangelo/docker-openvpn)
[![Docker Stars](https://img.shields.io/docker/stars/marcodangelo/AzureOpenVpn.svg)](https://hub.docker.com/r/marcodangelo/AzureOpenVpn/)
[![Docker Pulls](https://img.shields.io/docker/pulls/marcodangelo/AzureOpenVpn.svg)](https://hub.docker.com/r/marcodangelo/AzureOpenVpn/)
[![ImageLayers](https://images.microbadger.com/badges/image/marcodangelo/AzureOpenVpn.svg)](https://microbadger.com/#/images/marcodangelo/AzureOpenVpn)
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fmarcodangelo%2Fdocker-openvpn.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Fmarcodangelo%2Fdocker-openvpn?ref=badge_shield)


Use AzureOpenVPN to runa container in Azure 

Tested on Azure.com

#### Upstream Links

* Docker Registry @ [marcodangelo/AzureOpenVpn](https://hub.docker.com/r/marcodangelo/AzureOpenVpn/)
* GitHub @ [marcodangelo/docker-openvpn](https://github.com/marcodangelo/docker-openvpn)

## Quick Start

* Pick a name for the `$OVPN_DATA` data volume container. It's recommended to
  use the `ovpn-data-` prefix to operate seamlessly with the reference systemd
  service.  Users are encourage to replace `example` with a descriptive name of
  their choosing.

        OVPN_DATA="ovpn-data-example"

* Initialize the `$OVPN_DATA` container that will hold the configuration files
  and certificates.  The container will prompt for a passphrase to protect the
  private key used by the newly generated certificate authority.

        docker volume create --name $OVPN_DATA
        docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm marcodangelo/AzureOpenVpn ovpn_genconfig -u udp://VPN.SERVERNAME.COM
        docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm -it marcodangelo/AzureOpenVpn ovpn_initpki

* Start OpenVPN server process

        docker run -v $OVPN_DATA:/etc/openvpn -d -p 1194:1194/udp --cap-add=NET_ADMIN marcodangelo/AzureOpenVpn

* Generate a client certificate without a passphrase

        docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm -it marcodangelo/AzureOpenVpn easyrsa build-client-full CLIENTNAME nopass

* Retrieve the client configuration with embedded certificates

        docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm marcodangelo/AzureOpenVpn ovpn_getclient CLIENTNAME > CLIENTNAME.ovpn

## Next Steps

#