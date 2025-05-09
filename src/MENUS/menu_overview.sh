function menu_overview {
while true ; do
clear
unset m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12
unset s1 s2 s3 s4 s5 s6 s7 s8 s9 s10 s11 s12
unset i1 i2 i3 i4 i5 i6 i7 i8 i9 i10 i11 i12
unset r1 r2 r3 r4 r5 r6 r7 r8 r9 r10 r11 r12
unset menub1 menub2 menub3 menub4 menub5 menub6 menub7 menub8 menub9 menub10 menub11 munub12
unset bitcoininstalled lndinstalled fulcruminstalled electrsinstalled breinstalled btcpayinstalled
unset rtlinstalled electrsdkrinstalled mempoolinstalled publicpoolinstalled electrumxinstalled
unset thunderhubinstalled

set_terminal
please_wait
debug "line 7"
set_terminal 48 88

m1="${white}m1${orange}"
m2="${white}m2${orange}"
m3="${white}m3${orange}"
m4="${white}m4${orange}"
m5="${white}m5${orange}"
m6="${white}m6${orange}"
m7="${white}m7${orange}"
m8="${white}m8${orange}"
m9="${white}m9${orange}"
m10="${white}m10${orange}"
m11="${white}m11${orange}"
m12="${white}m12${orange}"

s1="${white}s1${orange}"
s2="${white}s2${orange}"
s3="${white}s3${orange}"
s4="${white}s4${orange}"
s5="${white}s5${orange}"
s6="${white}s6${orange}"
s7="${white}s7${orange}"
s8="${white}s8${orange}"
s9="${white}s9${orange}"
s10="${white}s10${orange}"
s11="${white}s11${orange}"
s12="${white}s12${orange}"

if grep -q bitcoin-end $ic ; then
    i1="    ${green}Y${orange}"
    bitcoininstalled="true"
    if [[ $bitcoinrunning == "true" ]] ; then
    r1="${green}Y${orange}"
    menub1="true"
    else
    r1="${red}N${orange}"
    menub1="false"
    fi
else
    i1="${red}     N${orange}"
    r1="${red}N${orange}"
    menub1="false"
    unset m1 s1 r1
fi

if grep -q lnd-end $ic || grep -q lnddocker-end $ic ; then
    i2="${green}Y${orange}"
    lndinstalled="true"
    if [[ $lndrunning == "true" ]] ; then
    r2="${green}Y${orange}"
    menub2="true"
    else
    r2="${red}N${orange}"
    menub2="false"
    fi
else
    i2="${red}     N${orange}"
    r2="${red}N${orange}"
    menub2="false"
    unset m2 s2 r2
fi

if grep -q fulcrum-end $ic ; then
    i3="${green}Y${orange}"
    fulcruminstalled="true"
    if [[ $fulcrumrunning == "true" ]] ; then
    r3="${green}Y${orange}"
    menub3="true"
    else
    r3="${red}N${orange}"
    menub3="false"
    fi
else
    i3="${red}     N${orange}"
    r3="${red}N${orange}"
    menub3="false"
    unset m3 s3 r3
fi 
if grep -q electrs-end $ic ; then
    i4="${green}Y${orange}"
    electrsinstalled="true"
    if [[ $electrsrunning == "true" ]] ; then
    r4="${green}Y${orange}"
    menub4="true"
    else
    r4="${red}N${orange}"
    menub4="false"
    fi
else
    i4="${red}     N${orange}"
    r4="${red}N${orange}"
    menub4="false"
    unset m4 s4 r4
fi
if grep -q btcrpcexplorer-end $ic || grep -q bre-end $ic ; then
    i5="${green}Y${orange}"
    breinstalled="true"
    if [[ $brerunning == "true" ]] ; then
    r5="${green}Y${orange}"
    menub5="true"
    else
    r5="${red}N${orange}"
    menub5="false"
    fi
else
    i5="${red}     N${orange}"
    r5="${red}N${orange}"
    menub5="false"
    unset m5 s5 r5
fi
if grep -q btcpay-end $ic ; then
    i6="${green}Y${orange}"
    btcpayinstalled="true"
    if [[ $btcpayrunning == "true" ]] ; then
    r6="${green}Y${orange}"
    menub6="true"
    else
    r6="${red}N${orange}"
    menub6="false"
    fi
else
    i6="${red}     N${orange}"
    r6="${red}N${orange}"
    menub6="false"
    unset m6 s6 r6
fi
if grep -q rtl-end $ic ; then
    i7="${green}Y${orange}"
    rtlinstalled="true"
    if [[ $rtlrunning == "true" ]] ; then
    r7="${green}Y${orange}"
    menub7="true"
    else
    r7="${red}N${orange}"
    menub7="false"
    fi
else
    i7="${red}     N${orange}"
    r7="${red}N${orange}"
    menub7="false"
    unset m7 s7 r7
fi

if grep -q electrsdkr-end $ic ; then
    i8="${green}Y${orange}"
    electrsdkrinstalled="true"
    if [[ $electrsdkrrunning == "true" ]] ; then
    r8="${green}Y${orange}"
    menub8="true"
    else
    r8="${red}N${orange}"
    menub8="false"
    fi
else
    i8="${red}     N${orange}"
    r8="${red}N${orange}"
    menub8="false"
    unset m8 s8 r8
fi

if grep -q mempool-end $ic ; then
    i9="${green}Y${orange}"
    mempoolinstalled="true"
    if [[ $mempoolrunning == "true" ]] ; then
    r9="${green}Y${orange}"
    menub9="true"
    else
    r9="${red}N${orange}"
    menub9="false"
    fi
else
    i9="${red}     N${orange}"
    r9="${red}N${orange}"
    menub9="false"
    unset m9 s9 r9
fi

if grep -q public_pool-end $ic ; then
    i10="${green}Y${orange}"
    publicpoolinstalled="true"
    if [[ $publicpoolrunning == "true" ]] ; then
    r10="${green}Y${orange}"
    menub10="true"
    else
    r10="${red}N${orange}"
    menub10="false"
    fi
else
    i10="${red}     N${orange}"
    r10="${red}N${orange}"
    menub10="false"
    unset m10 s10 r10
fi

if grep -q electrumx-end $ic ; then
    i11="${green}Y${orange}"
    electrumxinstalled="true"
    if [[ $electrumxrunning == "true" ]] ; then
    r11="${green}Y${orange}"
    menub11="true"
    else
    r11="${red}N${orange}"
    menub11="false"
    fi
else
    i11="${red}     N${orange}"
    r11="${red}N${orange}"
    menub11="false"
    unset m11 s11 r11
fi

if grep -q thunderhub-end $ic ; then
    i12="${green}Y${orange}"
    thunderhubinstalled="true"
    if [[ $thunderhubrunning == "true" ]] ; then
    r12="${green}Y${orange}"
    menub12="true"
    else
    r12="${red}N${orange}"
    menub12="false"
    fi
else
    i12="${red}     N${orange}"
    r12="${red}N${orange}"
    menub12="false"
    unset m12 s12 r12
fi

x="${orange}|$bright_blue"

set_terminal 42 110
echo -en "
########################################################################################################
$bright_blue           PROGRAM              $x            GO TO MENU         RUNNING          START/STOP        ${orange}
########################################################################################################
                                |
                                |
      Bitcoin                   |                $m1                $r1                $s1
                                |
      LND/LITD                  |                $m2                $r2                $s2
                                |
      Fulcrum                   |                $m3                $r3                $s3
                                |
      Electrs (non Docker)      |                $m4                $r4                $s4
                                |
      BTC RPC Explorer (BRE)    |                $m5                $r5                $s5
                                |
      BTCPay                    |                $m6                $r6                $s6
                                |
      RTL                       |                $m7                $r7                $s7
                                |
      Electrs (Docker)          |                $m8                $r8                $s8
                                |
      Mempool                   |                $m9                $r9                $s9
                                |
      Public Pool               |                $m10               $r10                $s10
                                |
      Electrum X                |                $m11               $r11                $s11
                                |
      Thunderhub                |                $m12               $r12                $s12
                                |
      ${red}r to refresh${orange}              |
                                |
########################################################################################################
$bright_blue Note: this is intentionally not a complete list of all apps available with Parmanode.
"

choose "xpmq"
echo -e "

"
read choice
jump $choice || { invalid ; continue ; } ; set_terminal

case $choice in
q|Q) exit ;; p|P) return 1 ;; ""|m|M) back2main ;;

r)
menu_overview
;;

m1) 
if [[ $bitcoininstalled == "true" ]] ; then
menu_bitcoin overview 
fi
;; # argument changes behaviour of "p" menu choice

m2) 
if [[ $lndinstalled == "true" ]] ; then
menu_lnd overview 
fi
;;

m3) 
if [[ $fulcruminstalled == "true" ]] ; then
menu_fulcrum overview 
fi
;;

m4) 
if [[ $electrsinstalled == "true" ]] ; then
menu_electrs overview 
fi
;;

m5) 
if [[ $breinstalled == "true" ]] ; then
menu_bre     overview 
fi
;;

m6) 
if [[ $btcpayinstalled == "true" ]] ; then
menu_btcpay  overview 
fi
;;

m7) 
if [[ $rtlinstalled == "true" ]] ; then
menu_rtl     overview 
fi
;;

m8) 
if [[ $electrsdkrinstalled == "true" ]] ; then
menu_electrs overview 
fi
;;

m9) 
if [[ $mempoolinstalled == "true" ]] ; then
menu_mempool overview 
fi
;;

m10) 
if [[ $publicpoolinstalled == "true" ]] ; then
menu_public_pool overview 
fi
;;

m11) 
if [[ $electrumxinstalled == "true" ]] ; then
menu_electrumx overview 
fi
;;

m12) 
if [[ $thunderhubinstalled == "true" ]] ; then
menu_thunderhub overview 
fi
;;

s1) 
if [[ $menub1 == "true" ]] ; then
clear ; please_wait
stop_bitcoin
else
clear ; please_wait
start_bitcoin
fi
;;
s2) 
if [[ $menub2 == "true" ]] ; then
clear ; please_wait
stop_lnd
else
clear ; please_wait
start_lnd
fi
;;
s3) 
if [[ $menub3 == "true" ]] ; then
set_terminal
echo "Fulcrum stopping..."
stop_fulcrum 
else
clear ; please_wait
set_terminal
echo "Fulcrum starting..."
start_fulcrum 
set_terminal
fi
;;
s4) 
if [[ $menub4 == "true" ]] ; then
clear ; please_wait
stop_electrs
else
clear ; please_wait
start_electrs
sleep 1
fi
;;
s5) 
if [[ $menub5 == "true" ]] ; then
clear ; please_wait
if [[ $computer_type == LinuxPC ]] ; then stop_bre ; fi
if [[ $OS == Mac || $computer_type == Pi ]] ; then bre_docker_stop ; fi
else
clear ; please_wait
if [[ $computer_type == LinuxPC ]] ; then start_bre ; fi
if [[ $OS == Mac || $computer_type == Pi ]] ; then bre_docker_start ; fi
fi
;;
s6) 
if [[ $menub6 == "true" ]] ; then
clear ; please_wait
stop_btcpay
else
clear ; please_wait
start_btcpay
fi
;;
s7) 
if [[ $menub7 == "true" ]] ; then
clear ; please_wait
docker stop rtl
else
clear ; please_wait
docker start rtl
fi
;;
s8) 
if [[ $menub8 == "true" ]] ; then
clear ; please_wait
docker_stop_electrs
else
clear ; please_wait
docker_start_electrs
fi
;;

s9)
if [[ $menub9 == "true" ]] ; then
clear ; please_wait
stop_mempool
else
clear ; start_mempool
fi
;;

s10)
if [[ $menub10 == "true" ]] ; then
clear ; please_wait
stop_public_pool
else
clear ; start_public_pool
fi
;;

s11)
if [[ $menub11 == "true" ]] ; then
clear ; please_wait
stop_electrumx
else
clear ; start_electrumx
fi
;;

s11)
if [[ $menub12 == "true" ]] ; then
clear ; please_wait
stop_thunderhub
else
clear ; start_thunderhub
fi
;;
esac
done

}
