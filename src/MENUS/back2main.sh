function back2main {

export main_loop=$((main_loop + 1)) 
if [[ $main_loop -gt 50 ]] ; then
announce "A função do menu principal já se chamou a si própria demasiadas vezes. É
provavelmente uma boa idéia sair do Parmanode e reiniciá-lo - isso vai liberar
um pouco da memória do computador."
fi
menu_main

#redundant...
exit
}
