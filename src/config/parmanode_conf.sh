function parmanode_conf_add {

#create config file if it doesn't exist.
if [[ ! -f $pc ]] ; then
touch $HOME/.parmanode/parmanode.conf
fi

#if no argument (-z $1) to the function, return.
if [[ -z $1 ]] ; then return 0 ; fi

# removing the argument from the config file first, to avoid
# duplication
parmanode_conf_remove "${1}"
# now add it by appending (-a)
echo "${1}" | tee -a $pc >$dn
}

########################################################################################

function parmanode_conf_remove {
gsed -i "/$1/d" $pc
}


