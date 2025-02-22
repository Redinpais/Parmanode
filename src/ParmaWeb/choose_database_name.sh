
function choose_database_name {

while true ; do
set_terminal ; echo -e "
########################################################################################

    The default name for the database and directory where information about the
    website is stored is called 'website'. This may be a problem for people tinkering
    and installing more than one site on the same computer. In that case you can
    choose one of the following names - Parmanode will check they don't already
    exists.

                        d)       website      $green(default) $orange
                        2)       website2
                        3)       website3
                        4)       website4
                        5)       website5
                        6)       website6
                        7)       website7
                        8)       website8
                        9)       website9


########################################################################################
"
choose x ; read choice 
jump $choice || { invalid ; continue ; } ; set_terminal
case $choice in
q|Q) exit ;; p|P) return 1 ;; m|M) back2main ;;
d) export website="website" ; break ;;
2) export website="website2" ; break ;;
3) export website="website3" ; break ;;
4) export website="website4" ; break ;;
5) export website="website5" ; break ;;
6) export website="website6" ; break ;;
7) export website="website7" ; break ;;
8) export website="website8" ; break ;;
9) export website="website9" ; break ;;
*) invalid ;;
esac
done

return 0
}