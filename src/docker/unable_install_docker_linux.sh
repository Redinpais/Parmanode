function docker_self_install_linux {
set_terminal_wider ; echo -e "
###########################################################################################################

       Instructions to install Docker yourself, using a package installer, are here:
$cyan
                https://docs.docker.com/engine/install/ubuntu/#install-from-a-package
$orange
###########################################################################################################
"
enter_continue ; set_terminal 
}
