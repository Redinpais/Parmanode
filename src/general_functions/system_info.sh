function which_os {
# This function just extracts and stores the operating system name

if [[ $(uname) == "Darwin" ]] #uname gives useful info about the system.
then
    export OS="Mac"
    if [[ -e $HOME/.parmanode/parmanode.conf ]] ; then parmanode_conf_add "OS=${OS}" >$dn ; fi
    # This is adding the variable to a configuration file.
    # Parmanode_conf_add takes an argument (the text after it is called) and adds that to 
    # The parmanode.conf file
    # I later realised this is unnecessary if I just "export" the variable, making it always available
    # I'll clean up the code later.
    return 0 
fi

if [[ $(uname) == "Linux" ]]
then
    export OS="Linux"
    if [[ -e $HOME/.parmanode/parmanode.conf ]] ; then parmanode_conf_add "OS=${OS}" >$dn ; fi
    return 0
fi

if [[ "$(uname)" == "MINGW32_NT" || "$(uname -s)" == "MINGW64_NT" ]] 
then
    check_if_win7
    if [[ -e $HOME/.parmanode/parmanode.conf ]] ; then parmanode_conf_add "OS=${OS}" >$dn ; fi
    exit 1
fi
echo "unknown OS, exiting." ; sleep 3

}

function Linux_distro {
    
if [[ $OS == "Linux" ]] ; then

    if [ -f /etc/debian_version ]; then
    parmanode_conf_add "Linux=Debian"

    elif [ -f /etc/lsb-release ]; then
    parmanode_conf_add "Linux=Ubuntu"

    else
    parmanode_conf_add "Linux=Unknown"

    fi

else
    return 1
fi

return 0
}



function check_if_win7 {
# will return win7+, linux, or not_win string.
if [[ $(uname -s) == MINGW* ]] ; then
    version=$(wmic os get version | grep -oE "[0-9]+.[0-9]+")
    if (( $(echo "$version >= 6.1" | bc -l) )) ; then
        export OS="Win"
    else
        export OS="Win_old"
    fi
else
    export OS="Not_Win"
fi
return 0
}
function which_computer_type {

if [[ $OS == "Linux" ]] ; then

   if [[ $(uname -m) == "aarch64" || \
         $(uname -m) == "arm"     || \
         $(uname -m) == "armhf"   || \
         $(uname -m) == "armv7l"  || \
         $(uname -m) == "armv6l"  || \
         $(uname -m) == "armv8l"        ]] ; then
        
            export computer_type=Pi 
            parmanode_conf_add "computer_type=Pi" >$dn
   else
            export computer_type=LinuxPC
            parmanode_conf_add "computer_type=LinuxPC" >$dn
   fi

    
else
            export computer_type=Mac 
            parmanode_conf_add "computer_type=Mac" >$dn
fi
}

function get_ip_address {

if [[ $(uname) == "Linux" ]] ; then

    if ! which ip >$dn 2>&1 ; then
        clear
        enter_continue "Installing necessary ip function (iproute2)..."
        sudo apt-get update -y && sudo apt-get install iproute2 -y
    fi

    if [[ -e /.dockerenv ]] ; then #docker container detected
        export IP=$( ip a | grep "inet" | grep 172 | awk '{print $2}' | cut -d '/' -f 1 | head -n1 )
    else 
        export IP=$( ip a | grep "inet " | grep -v 127.0.0.1 | grep -v 172.1 | awk '{print $2}' | cut -d '/' -f 1 | head -n1 )
    fi
fi

if [[ $(uname) == "Darwin" ]] ; then export IP=$( ifconfig | grep "inet " | grep -v 127.0.0.1 | grep -v 172.1 | awk '{print $2}' | head -n1 ) ; fi
# Through a series of searches (grep), the results being passed by the | symbol to the right and being
# searched on again, the results are narrowed down.
# awk is used to print out a field (like selecting a column in an excel row), and cut
# can split text according to a delimeter (-d) and choosing a resulting field (-f)
}

function IP_address {
count=0
while [[ $count -lt 3 ]] ; do 
export external_IP=$(curl -s ifconfig.me)
count=$((count+1))
parmanode_conf_remove "external_IP"
parmanode_conf_add "external_IP=$external_IP"
source $pc || { sleep 2 ; continue ; }
break
done

source $pc || { parmanode_conf_remove "external_IP" ; }

if [[ $1 == get ]] ; then
return 0
fi

#IP variable is printed for the user.
if [[ $OS == Linux ]] ; then
message="    You can actually change the hostname of this computer. Just edit the name 
    in the file /etc/hostname. For example if you put 'parmanode' in there, just a 
    single line of text, then you can access the computer with:
$cyan
       ssh $USER@parmanode.local $orange

    Cool huh? I think it's cool."
else
unset message
fi



set_terminal_custom 46
echo -e "
########################################################################################


    Your computer's IP address is:                   $cyan             $IP $orange


    Your computer's \"self\" IP address should be:                  127.0.0.1


    For reference, every computer's default self IP address is    127.0.0.1 
                                                            and   localhost


    To access this computer from another computer ON THE SAME NETWORK, you can type 
    in the terminal of the other computer (even Windows):
$green
        ssh $USER@$IP
$orange
    ssh needs to be enabled on this system (it usually is by default).

    If you really want to use Windows (eww) to access this computer by ssh, you'll
    have to install a program called Putty on the Windows machine.
$bright_blue
    The EXTERNAL IP for your router (Your Home's IP not just this device):

$green                                                                   $external_IP  $orange

$message

########################################################################################
"
enter_continue ; jump $enter_cont
return 0
}

function get_linux_version_codename {
. /etc/os-release && VC=$VERSION_CODENAME
. $HOME/.parmanode/parmanode.conf #(fix ID variable)



# Linux Mint has Ubunta equivalents for this purpose
if [[ $VC == "vera" ]] ; then VCequivalent="jammy" ; parmanode_conf_add "VCequivalent=$VCequivalent" 
elif [[ $VC == "vanessa" ]] ; then VCequivalent="jammy" ; parmanode_conf_add "VCequivalent=$VCequivalent"  
elif [[ $VC == "una" ]] ; then VCequivalent="focal" ; parmanode_conf_add "VCequivalent=$VCequivalent" 
elif [[ $VC == "uma" ]] ; then VCequivalent="focal" ; parmanode_conf_add "VCequivalent=$VCequivalent" 

elif [[ $VC == "ulyssa" ]] ; then VCequivalent="focal" ; parmanode_conf_add "VCequivalent=$VCequivalent"  
elif [[ $VC == "ulyana" ]] ; then VCequivalent="focal" ; parmanode_conf_add "VCequivalent=$VCequivalent" 
elif [[ $VC == "tricia" ]] ; then VCequivalent="bionic" ; parmanode_conf_add "VCequivalent=$VCequivalent"
elif [[ $VC == "tina" ]] ; then VCequivalent="bionic" ; parmanode_conf_add "VCequivalent=$VCequivalent"  
elif [[ $VC == "tessa" ]] ; then VCequivalent="bionic" ; parmanode_conf_add "VCequivalent=$VCequivalent" 
elif [[ $VC == "tara" ]] ; then VCequivalent="bionic" ; parmanode_conf_add "VCequivalent=$VCequivalent" 
elif [[ $VC == "elsie" ]] ; then VCequivalent="bullseye" ; parmanode_conf_add "VCequivalent=$VCequivalent" 
#new 
elif [[ $VC == "victoria" ]] ; then VCequivalent="jammy" ; parmanode_conf_add "VCequivalent=$VCequivalent"  
elif [[ $VC == "virginia" ]] ; then VCequivalent="jammy" ; parmanode_conf_add "VCequivalent=$VCequivalent"
elif [[ $VC == "faye" ]] ; then VCequivalent="bullseye" ; parmanode_conf_add "VCequivalent=$VCequivalent"
#with these two lines, all the other should become redundant, but I have to check it before deleting the above.
elif [[ -n $UBUNTU_CODENAME ]] ; then VCequivalent="$UBUNTU_CODENAME" ; parmanode_conf_add "VCequivalent=$VCequivalent"
elif [[ -n $DEBIAN_CODENAME ]] ; then VCequivalent="$DEBIAN_CODENAME" ; parmanode_conf_add "VCequivalent=$VCequivalent"

else VCequivalent=$VC

fi
debug "in get_linux_version_codename, VCequivalent is $VCequivalent"
parmanode_conf_add "VCequivalent=$VCequivalent"

}

function check_chip {
#Expected resulting options
    # x86_64, arm64, aarch64, armv6l, armv7l

    export chip="$(uname -m)" 

    parmanode_conf_add "chip=$chip"

}

function check_architecture {
    if [[ $(uname) == Linux ]] ; then
    architecture=$(lscpu | grep Architecture | awk '{print $2}')
    if [[   $architecture == armv6l || \
            $architecture == armv7l || \
            $architecture == i386   || \
            $architecture == i486   || \
            $architecture == i586   || \
            $architecture == i686   ]] ; then 
parmanode_conf_add "architecture=$architecture"

announce \
"This seems to be a 32-bit machine. Parmanode and most apps you
install will not work properly, even if they install. Please run 
this on a 64-bit machine. Bitcoin Core will work, but no promisses 
with any other app you might want to install. Be warned." \
" 
Hit <control-c> to exit."

fi
fi
}


