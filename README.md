# AzureOpenVPN Container



Use AzureOpenVPN to run a docker container in Azure 



#### Upstream Links

* Docker Registry @ [marcodangelo/AzureOpenVpn](https://hub.docker.com/r/marcodangelo/OpenVpn/)
* GitHub @ [marcodangelo/AzureOpenVPN](https://github.com/marcodangelo/AzureOpenVPN)

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