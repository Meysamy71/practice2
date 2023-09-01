#!/bin/bash

clear

echo "#############################################"
echo "#      `date +%Y/%m/%d-%H:%M:%S`                  #"
echo "#    Wellcome to Restore Manager            #"
echo "#                                           #"
echo "#  Server Uptime is `uptime -p`  #"
echo "#############################################"





BACKUP_NAME=`ls -d */ |tr -d "/"`
BACKUP_PATH=/home/devops/dockers
PS3="Select item please: "

select ITEM in ${BACKUP_NAME[@]} Exit
do
	if [[ $ITEM = *xit  ]]
	then
		exit
	else	
		BKP=`ls $BACKUP_PATH/$ITEM`
		select VAR in ${BKP[@]} Exit
		do

			if [[ $VAR = *xit  ]]
			then
				exit
			else	
				cp $BACKUP_PATH/$ITEM/$VAR /tmp/restore
				xz -d /tmp/restore/*.tar.xz
				docker load < /tmp/restore/*.tar
				rm /tmp/restore/*
				echo "backup restore successfuly"
				exit
			fi
		done
	fi
done

