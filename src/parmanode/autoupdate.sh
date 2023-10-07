function autoupdate {
if [[ -f $HOME/.parmanode/hide_messages.conf ]] ; then
. $HOME/.parmanode/hide_messages.conf >/dev/null
fi

if [[ ${message_autoupdate} != "1" ]] ; then 
while true
do
set_terminal ; echo -e "
########################################################################################
$cyan
                        P A R M A N O D E : Auto-updates $orange

    WOULD YOU LIKE THE PROGRAM TO STAY UP TO DATE WITHOUT YOUR INVOLVEMENT? 

    Parmanode is frequently improved, either with typos, or correcting smol bugs here
    or there, and occasionally serious new features. With autoupdates, parmanode will 
    silently update itself at 3:30am and takes only a few seconds.


                       y)      I thought you'd never ask.

                       n)      Hands off, I like this version forever.

                       nooo)   Go away and never ask again.
  $bright_yellow  

    It's important to realise that updates to parmanode DO NOT change any programs
    you have installed - it only changes the Parmanode software itself (ie the 
    Parmanode menu scripts you interact with). $orange


########################################################################################
"

choose "xpq" ; read choice ; set_terminal 
case $choice in
q|Q) exit ;; p|P) return 1 ;;

y|Y) 
parmanode_conf_add "autoupdate=true" 
hide_messages_add "autoupdate" "1" 
cat << 'EOF' > "$HOME/.parmanode/update_script.sh"
#!/bin/bash
cd $HOME/parman_programs/parmanode && git pull
EOF

sudo chmod +x $HOME/.parmanode/update_script.sh

(crontab -l; echo "30 3 * * *  [ -x $HOME/.parmanode/update_script.sh ] && $HOME/.parmanode/update_script.sh" >/dev/null 2>&1) 2>/dev/null | crontab -
;;

n|N)
return 0 ;;

nooo|NOOO|Nooo) 
hide_messages_add "autoupdate" "1" ; return 0 
return 0
;;

*) 
invalid ;;
esac 
done
fi
}