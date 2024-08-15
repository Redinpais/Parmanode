function make_parmanode_tor_service {
if [[ $OS == Mac ]] ; then
torrc="/usr/local/etc/tor/torrc"
varlibtor="/usr/local/var/lib/tor"
else
torrc="/etc/tor/torrc"
varlibtor="/var/lib/tor"
fi

if grep -q "parmanode-service" < $torrc ; then return 0 ; fi

echo "HiddenServiceDir $varlibtor/parmanode-service/" | sudo tee -a $torrc >/dev/null 2>&1
echo "HiddenServicePort 6150 127.0.0.1:6150" | sudo tee -a $torrc >/dev/null 2>&1
restart_tor
}