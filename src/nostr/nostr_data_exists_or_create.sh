function nostr_data_exists_or_create {
#internal or external
unset file

if [[ $drive_nostr == external ]] ; then
file=$pd/nostr_data
elif [[ $drive_nostr == internal ]] ; then
file=$HOME/.nostr_data
elif [[ $drive_nostr == custom ]] ; then
file=$drive_nostr_custom_data
fi

if [[ -e $file ]] ; then
debug "file is $file"
while true ; do
set_terminal ; echo -e "
########################################################################################
$cyan
    $file$orange already exists. What is to be done?

        1)    Delete the data and start over

        2)    Use the data

        3)    Back up the data to ${file}_bakup_$(date +'%Y-%m-%d')
              and start over

########################################################################################
"
choose xpmq ; read choice ; set_terminal
case $choice in
q|Q) exit ;; p|P) return 1 ;; m|M) back2main ;;
1)
rm -rf $file
mkdir $file
break
;;
2)
break
;;
3)
mv $file ${file}_backup_$(date +'%Y-%m-%d')
mkdir $file
break
;;
*)
invalid 
;;
esac
done
else
mkdir $file
fi

}