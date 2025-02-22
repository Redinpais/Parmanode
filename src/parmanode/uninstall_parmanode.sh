function uninstall_parmanode {
local file="$dp/installed.conf"
set_terminal

while true ; do
echo -e "
########################################################################################
$red
                                Uninstall Parmanode??
$orange
    This will first give you the option to remove programs installed with Parmanode 
    before removing the Parmanode installation files and configuration files. 
    
    Finally, you'll have the option to delete the Parmanode script directory.

    Continue?
$red
                        y)        Get rid of it
$green
                        n)        Nah, go back
$orange
########################################################################################
"
choose "epmq" ; read choice
jump $choice || { invalid ; continue ; } ; set_terminal
case $choice in
q|Q) exit ;; p|P) return 1 ;; m|M) back2main ;;
y|yes|YES|Y) break ;;
*) invalid ;;
esac
done

if grep -q "bitcoin" $file #checks if bitcoin is installed in install config file.
then uninstall_bitcoin #confirmation inside function 
set_terminal
else 
set_terminal
fi #ends if bitcoin installed/unsinstalled

if grep -q "fulcrum" $file 
then uninstall_fulcrum #both linux & mac, confirmations inside functions
set_terminal
fi

if grep -q "btcpay" $file 
then uninstall_btcpay # confirmation inside function, linux and mac.
set_terminal
fi

if grep -q "electrum" $file 
then
uninstall_electrum
set_terminal
fi

if grep -q "lnd" $file 
then
uninstall_lnd
set_terminal
fi


if grep -q "rtl" $file 
then
uninstall_rtl #Confirmation inside function
set_terminal
fi

if grep -q "sparrow" $file 
then
uninstall_sparrow
set_terminal
fi

if grep -q "tor-server" $file 
then
uninstall_tor_webserver
set_terminal
fi

if grep -q "specter" $file 
then
uninstall_specter
set_terminal
fi

if grep -q "electrs" $file 
then
uninstall_electrs
set_terminal
fi

if grep -q "btcrpcexplorer" $file
then
uninstall_btcrpcexplorer
set_terminal
fi

if grep -q "parmanshell" $file 
then
uninstall_parmanshell
set_terminal
fi

set_terminal
if [[ $debug == 0 ]] ; then 
while true ; do
clear
echo -e "
########################################################################################
$red
                            Parmanode will be uninstalled
$orange
########################################################################################
"
choose "epmq" ; read choice 
jump $choice || { invalid ; continue ; } ; set_terminal
case $choice in
m|M) back2main ;; q|Q) exit ;; p|P) return 1 ;; "") break ;; *) invalid ;; 
esac
done
unset choice
fi

#check other programs are installed in later versions.

if [[ $OS == "Linux" ]] ; then

        if [[ $EUID -eq 0 ]] ; then  #if user running as root, sudo causes command to fail.
                umount /media/$HOME/parmanode* > $dn 2>&1
            else
                sudo umount /media/$HOME/parmanode* > $dn 2>&1
            fi
    fi

    if [[ $OS == "Mac" ]] ; then

        disktultil unmount "parmanode"

        fi

#uninstall parmanode directories and config files contained within.
sudo rm -rf $HOME/.parmanode >$dn 2>&1

#removes all parmanode crontab entries
autoupdate off

cleanup_bashrc_zshrc

set_terminal ; echo -e "
########################################################################################

    Do you also wish to delete the Parmanode$cyan script directory$orange 

                                   y)    Yes

                                   n)    No

    If you choose yes, then this program will continue to run from computer memory, 
    but you won't be able to start it up again unless you install it again.

######################################################################################## 
"
read choice
case $choice in y|Y) 
#remove desktop icon file
rm $HOME/Desktop/*un_parmanode* >$dn
rm $HOME/Desktop/*armanode* >$dn
rm $HOME/Desktop/parmanode.desktop >$dn
debug "delete desktop icon"
rm $HOME/.icons/PNicon*
debug "delete .icons"
sudo rm -rf $pn
debug "remove original dir"
;;
esac

set_terminal
echo -e "
########################################################################################

                        Parmanode has been uninstalled       
                                                                       $red Happy now? $orange
########################################################################################
"
sleep 3
exit
}
