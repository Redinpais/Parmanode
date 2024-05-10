function menu_add_wallets {
while true

do
menu_add_source
set_terminal_higher
echo -e "
########################################################################################
#                                                                                      #
#    P A R M A N O D E --> Main Menu --> Install Menu  -->$cyan Wallet Install $orange             #
#                                                                                      #
########################################################################################
#                                                                                      #
#                                                                                      #
# Not yet installed...                                                                 #
#                                                                                      #"
if [[ -n $sparrow_n ]]         ; then echo  "$sparrow_n"; fi
if [[ -n $electrum_n ]]        ; then echo  "$electrum_n"; fi
if [[ -n $specter_n ]]         ; then echo  "$specter_n"; fi
if [[ -n $rtl_n ]]             ; then echo  "$rtl_n"; fi
if [[ -n $thunderhub_n ]]             ; then echo  "$thunderhub_n"; fi
if [[ -n $lnbits_n ]]           ; then echo  "$lnbits_n"; fi
if [[ -n $trezor_n ]]           ; then echo  "$trezor_n"; fi
if [[ -n $bitbox_n ]]           ; then echo  "$bitbox_n"; fi
if [[ -n $ledger_n ]]           ; then echo  "$ledger_n"; fi

echo "#                                                                                      #
# Installed...                                                                         #
#                                                                                      #"
if [[ -n $sparrow_i ]]         ; then echo  "$sparrow_i"; fi
if [[ -n $electrum_i ]]        ; then echo  "$electrum_i"; fi
if [[ -n $specter_i ]]         ; then echo  "$specter_i"; fi
if [[ -n $rtl_i ]]             ; then echo  "$rtl_i"; fi
if [[ -n $thunderhub_i ]]             ; then echo  "$thunderhub_i"; fi
if [[ -n $lnbits_i ]]          ; then echo  "$lnbits_i"; fi
if [[ -n $trezor_i ]]          ; then echo  "$trezor_i"; fi
if [[ -n $bitbox_i ]]          ; then echo  "$bitbox_i"; fi
if [[ -n $ledger_i ]]          ; then echo  "$ledger_i"; fi
echo "#                                                                                      #
# Failed installs (need to uninstall)...                                               #
#                                                                                      #"
if [[ -n $sparrow_p ]]         ; then echo -e "$pink$sparrow_p$orange"; fi
if [[ -n $electrum_p ]]        ; then echo -e "$pink$electrum_p$orange"; fi
if [[ -n $specter_p ]]         ; then echo -e "$pink$specter_p$orange"; fi
if [[ -n $rtl_p ]]             ; then echo -e "$pink$rtl_p$orange"; fi
if [[ -n $thunderhub_p ]]             ; then echo -e "$pink$thunderhub_p$orange"; fi
if [[ -n $lnbits_p ]]          ; then echo -e "$pink$lnbits_p$orange"; fi
if [[ -n $trezor_p ]]          ; then echo -e "$pink$trezor_p$orange"; fi
if [[ -n $bitbox_p ]]          ; then echo -e "$pink$bitbox_p$orange"; fi
if [[ -n $ledger_p ]]          ; then echo -e "$pink$ledger_p$orange"; fi
echo "#                                                                                      #
########################################################################################
"
choose "xpmq"
if [[ $1 == wt ]] ; then choice=th 
else
read choice
fi

case $choice in

m|M) back2main ;;
    
    s|S|Sparrow|sparrow|SPARROW)
       if [[ -n $sparrow_n ]] ; then
       install_sparrow
       back2main 
       fi
       ;;
   r|R|RTL|rtl|Rtl)
      if [[ -n $rtl_n ]] ; then
      install_rtl 
      back2main 
      fi
      ;;
   th)
      if [[ -n $thunderhub_n ]] ; then
      install_thunderhub
      back2main
      fi
      ;;
   e|E|electrum|Electrum|ELECTRUM)
      if [[ -n $electrum_n ]] ; then
      install_electrum
      back2main 
      fi
      ;;
   specter|Specter|SPECTER)
      if [[ -n $specter_n ]] ; then
      install_specter
      back2main 
      fi
      ;;
   lnb|LNB|Lnb)
      if [[ -n $lnbits_n ]] ; then
        if [[ $OS == "Mac" ]] ; then no_mac ; return 0 ; fi
        install_lnbits
        back2main 
      fi
      ;;
   trz|TRZ|Trz)
      if [[ -n $trezor_n ]] ; then
      install_trezor
      back2main 
      fi
      ;;
   bb|BB|Bb)
      if [[ -n $bitbox_n ]] ; then
      install_bitbox 
      back2main 
      fi
      ;;
   
   ll|LL|Ll)
      if [[ -n $ledger_n ]] ; then
      install_ledger
      back2main 
      fi
      ;;

    q|Q|quit|QUIT)
        exit 0
        ;;
    p|P)
        menu_add_new
        ;;
    *)
        invalid
        continue
        ;;
esac
done

return 0

}
