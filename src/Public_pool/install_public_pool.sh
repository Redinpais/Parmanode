function install_public_pool {

if ! which docker >/dev/null 2>&1 ; then install_docker_linux ; fi

cd $hp

if [[ $computer_type != Pi ]] ; then #Pi's can't build this image, it will be pulled.
git clone --depth 1 https://github.com/benjamin-wilson/public-pool.git public_pool
fi

git clone --depth 1 https://github.com/benjamin-wilson/public-pool-ui.git public_pool_ui
installed_conf_add "public_pool-start"

########################################################################################
# Start with public_pool
########################################################################################
cd $hp/public_pool
make_public_pool_env ; debug "made env"
# Add ZMQ connection to bitcoin.conf
# Parmanode uses port 3000 for RTL, so can't use that for pool.
echo "zmqpubrawblock=tcp://*:5000" | tee -a $bc >/dev/null

#start container
if [[ $OS == Linux ]] ; then

    if [[ $computer_type == Pi ]] ; then
    docker run -d --name public_pool --network=host -v $hp/public_pool/.env:/.env parmanthe/public_pool:parmanode ; debug "run pool done"
    else
    docker build -t public_pool . ; debug "build done"
    docker run -d --name public_pool --network=host -v $hp/public_pool/.env:/.env public_pool ; debug "run pool done"
    fi

elif [[ $OS == Mac ]] ; then

    docker run -d --name public_pool -p 3333:3333 -p 3334:3334 -v $hp/public_pool/.env:/.env public_pool ; debug "run pool done"

fi


########################################################################################
# Next public_pool_ui
########################################################################################
cd $hp/public_pool_ui
docker build -t public_pool_ui . ; debug "build done"
docker run -d --name public_pool_ui -p 5050:80 public_pool_ui

if docker ps | grep "public_pool" | grep -q "public_pool_ui" ; then
success "Public Pool" "being installed"
installed_conf_add "public_pool-end"
else
announce "Something went wrong"
fi
}
