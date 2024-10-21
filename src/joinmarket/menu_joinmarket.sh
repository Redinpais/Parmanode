function menu_joinmarket {

while true ; do 
if docker ps | grep -q joinmarket ; then
joinmarket_running="${green}RUNNING$orange"
else
joinmarket_running="${red}NOT RUNNING$orange"
fi

set_terminal ; echo -en "
########################################################################################$cyan
                                J O I N M A R K E T $orange
########################################################################################

    JoinMarket is:    $joinmarket_running

$cyan
                      start)$orange       Start JoinMarket Docker container
$cyan
                      stop)$orange        Stop JoinMarket Docker container
$cyan
                      man)$orange         Manually access container and mess around
$cyan
                      cr)$orange          Create JoinMarket Wallet (with info)
$cyan
                      delete)$orange      Delete JoinMarket Wallet 
$cyan
                      display)$orange     Display addresses

$orange   
########################################################################################
"
choose "xpmq" ; read choice ; set_terminal
case $choice in 
m|M) back2main ;;
q|Q|QUIT|Quit) exit 0 ;;
p|P) menu_use ;; 

start)
docker start joinmarket
;;
stop)
docker stop joinmarket
;;
man)
clear
enter_continue "Type exit and <enter> to return from container back to Parmanode"
docker exec -it joinmarket bash
;;
cr)
    jm_create_wallet_tool
    docker exec -it joinmarket bash -c '/jm/clientserver/scripts/wallet-tool.py generate' 
    enter_continue
    ;;
delete)
    delete_jm_wallets
    ;; 

display)
    display_jm_addresses
    ;; 
*)
invalid
;;

esac
done
}

function delete_jm_wallets {

set_terminal ; echo -e "
########################################################################################

    The following is a list of the contents of$cyan $HOME/.joinmarket/wallets/:
$pink
$(ls $HOME/.joinmarket/wallets/)
$orange

    Are you sure you want to delete everything in there?
$red
                 yolodelete)   delete it all
$green
                 *)            Any other key will abort
$orange
########################################################################################
"
choose xpmq ; read choice ; set_terminal
case $choice in
q|Q) exit ;; p|P) return 1 ;; m|M) back2main ;;
yolodelete)
sudo rm -rf $HOME/.joinmarket/wallets/*
enter_continue "DONE"
;;
*)
return 1
;;
esac
}


function display_jm_addresses {

    if [[ ! -e $HOME/.joinmarket/wallets/wallet.jmdat ]] ; then
    announce "${cyan}wallet.jmdat$orange does not exist"
    return
    fi

    docker exec -it joinmarket bash -c '/jm/clientserver/scripts/wallet-tool.py wallet.jmdat display' | tee /tmp/jmaddresses

    if grep -q "just restart this joinmarket application" < /tmp/jmaddresses ; then
    enter_continue "$pink
    This always happens the first time you access the display function.
    Please hit enter to run the display command again.
    $orange"
    docker exec -it joinmarket bash -c '/jm/clientserver/scripts/wallet-tool.py wallet.jmdat display' | tee /tmp/jmaddresses
    fi

clear
sed -i '1,/[Mm]ixdepth/{/[Mm]ixdepth/!d}' /tmp/jmaddresses
clear
less /tmp/jmaddresses
#rm /tmp/jmaddresses >$dn 2>&1
enter_continue

}
#Use `bitcoin-cli rescanblockchain` if you're recovering an existing wallet from backup seed
#Otherwise just restart this joinmarket application.