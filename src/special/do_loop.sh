function do_loop {

#sudo will be needed. Running it early here, getting it out of the way, 
#and it stays in the cache for a while.
sudo true ;

#check script is being run from parmanode directory so relative paths work
#-f checks if a file exists in the working directory. If it doesn't, it 
#means the run_parmanode.sh file is not in the correct location.

# source all the modules. Exclude executable scripts which aren't modules. Modules
# are bits of codes saved elseshere. They are "sourced" to load the code into memory.

	for file in $HOME/parman_programs/parmanode/src/**/*.sh ; do #for every file that ends in .sh, up to a directory
	#length of 1, attach its name to the variable "file" then run the code below, 
	#looping so each file gets sourced.

		if [[ $file != *"/postgres_script.sh" ]]; then #The if statement excludes one file - can remove later.
	    source $file #"source" or also represented by "." means to run the code in the file.
		#They doesn't need #!/bin/bash (or variations) statements inside, because it is being called by 
		# this program.  
		fi 

	done #ends the loop



parmanode_variables $@ #CANNOT USE CUSTOM DEBUG FUNCTION BEFORE THIS"

#make sure gsed words early, but after loading variables. 
#The sed command is not consistent between Linux and Mac,
#so I'll always use gsed (works on Mac like sed on Linux) and on Linux, the symlink
#gsed will point to sed, making code easier to write and read.
gsed_symlink 

set_colours #just exports variables with colour settings to make it easier to code with colours
            #parmanode.conf later may override theme
debug "printed colours" "silent"
#if [[ $debug == 1 ]] ; then echo -e "${orange}printed colours, hit <enter>" ; read ; fi

test_standard_install

set_terminal


#drive structure
make_home_parmanode 
make_dot_parmanode # NEW INSTALL FLAG ADDED HERE 
parmanode_conf_add # With no argument after the function, this will create a 
                   # parmanode.conf file if it doesnt' exist.
if [[ ! -e $ic ]] ; then touch $ic ; fi

# Load config variables
source $HOME/.parmanode/parmanode.conf >$dn 2>&1 

# If docker is set up on the machine, then it is detected by Parmanode
# and added to the config file
if [[ -f $ic ]] ; then #execute only if an installed config file exits otherwise not point.
	if ([[ $(uname) == Darwin ]] && ( which docker >$dn )) || \
	( [[ $(uname) == Linux ]] && which docker >$dn && id | grep -q docker ) ; then
		if ! grep -q docker-end $ic ; then
			installed_config_add "docker-end" 
		fi
	else installed_config_remove "docker"
	fi
fi

#add to run count
rp_counter

test_internet_connected || exit
########################################################################################
#Intro
########################################################################################
set_terminal # custom function for screen size and colour.
# argument "m" sets skip_intro to true in parman_variables

#btcpayinstallsbitcoin is for a docker container installation initiated by btcpay installation.
if [[ $1 != menu ]] ; then
   if [[ $skip_intro != "true" && $btcpayinstallsbitcoin != "true" ]] ; then intro ; instructions ; fi
fi

#If the new_install file exists (created at install) then offer to update computer.
#then delete the file so it doesn't ask again. 
# .new_install created inside a function that creates .parmanode directory for the first time
if [[ $btcpayinstallsbitcoin != "true" ]] ; then
if [[ -e $HOME/.parmanode/.new_install ]] ; then

	# If Parmanode has never run before, make sure to get latest version of Parmanode
	cd $HOME/parman_programs/parmanode && git config pull.rebase false >$dn 2>&1 && git pull && needs_restart="true" >$dn 2>&1

update_computer 
rm $HOME/.parmanode/.new_install
else
autoupdate
fi

if [[ $needs_restart == "true" ]] ; then
announce "An update to Parmanode was made to the latest version. Please restart Parmanode."
exit
fi
fi #end btcpayinstallsbitcoin
#Health check
parmanode1_fix
#prompts every 20 times parmanode is run (reducing load up time of Parmanode)
if [[ $rp_count == 1 || $((rp_count % 20 )) == 0 ]] ; then
   #environment checks
   bash_check 
   check_architecture 
fi
apply_patches

#Add Parmashell (do after patches)
install_parmashell 
# get version, and suggest user to update if old.

[[ $btcpayinstallsbitcoin == "true" ]] || update_version_info 

if [[ $exit_loop == "false" ]] ; then return 0 ; fi

# set "trap" conditions; currently makes sure user's terminal reverts to default colours
# when they exit.
clean_exit 

###### TESTING SECTION #################################################################

debug "Pausing here. IP: $IP" "silent" #when debugging, I can check for error messages and syntax errors
if [[ $enter_cont == d ]] ; then unset debug ; fi
# before the screen is cleared.


if [[ $test == 1 ]] ; then
announce "no test available presently. Exiting."
fi

if [[ $fix == 1 ]] ; then
announce "no fixes available presently. Exiting."
exit
fi

########################################################################################
#Special functions
########################################################################################
if [[ $bash == 1 && $OS == Linux ]] ; then 
#bash --rcfile <(source $HOME/.bashrc ; source $pn/source_parmanode.sh)
echo -e "Entering bash inception..."
sleep 0.5
bash --rcfile $pn/src/tools/rcfile
exit 
elif [[ $bash == 1 && $OS == Mac ]] ; then
echo -e "Entering bash inception..."
sleep 0.5
bash --rcfile $pn/src/tools/rcfile
exit 
fi

if [[ $uninstall_homebrew == true ]] ; then
uninstall_homebrew || exit
success "Homebrew uninstalled"
fi


########################################################################################
if [[ $arg1 == "clear" ]] ; then
clearup_chain
echo "exiting ..."
sleep 2
exit
fi
########################################################################################
if [[ $btcpayinstallsbitcoin == "true" ]] ; then install_bitcoin ; exit ; fi

#message of the day
if [[ $1 != menu ]] ; then
motd
fi

#make sure debug file doesn't get too big
truncatedebuglog

if ! grep -q "parmashell_functions" $bashrc ; then
echo "function rp { cd $HOME/parman_programs/parmanode ; ./run_parmanode.sh \$@ ; }" | sudo tee -a $bashrc >$dn 2>&1
fi

jump $1
# This is the main program, which is a menu that loops.
menu_main

}
