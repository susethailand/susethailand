#!/bin/bash

#: Title       : rsync_inc.sh
#: Date Created: 2012-03-01
#: Last Edit   : 2012-03-09
#: Author      : SONTAYA PITUBT <susethailand.com@gmail.com>
#: Version     : 1.0.0
#: Description : Rsync incremental backups script
#: Options     : 

#
# This is the standard GPL Statement, leave at the top of the script.
# Just use the command show_gpl after this function for it to be shown.
#

function show_gpl {
echo ""
echo "rsync_inc.sh is a bash script file written to be used with SUSE Linux."
echo "Copyright (C) 2012 by SONTAYA POTIBUT, susethailand.com@gmail.com"
echo ""
echo "This program is free software; you can redistribute it and/or modify"
echo "it under the terms of the GNU General Public License as published by"
echo "the Free Software Foundation; either version 2 of the License, or"
echo "(at your option) any later version."
echo ""
echo "This program is distributed in the hope that it will be useful,"
echo "but WITHOUT ANY WARRANTY; without even the implied warranty of"
echo "MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the"
echo "GNU General Public License for more details."
echo ""
echo "You should have received a copy of the GNU General Public License"
echo "along with this program; if not, write to the Free Software"
echo "Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA"
echo ""
}

#mail setting
MAILFROM="logs@domain.com"
MAILADMIN="it.support@domain.com"

#log files
LOGHOME="/data/storage_branches/rsync_home.log"
LOGDATA="/data/storage_branches/rsync_data.log"
echo $'\n\n' > $LOGHOME
echo $'\n\n' > $LOGDATA

#todays date
DAY0=$(date +%Y-%m-%d)

#yesterdays
DAY1=$(date +%Y-%m-%d -d "1 days ago")

#2 days ago
DAY2=$(date +%Y-%m-%d -d "2 days ago")

#30 days ago
DAY30=$(date +%Y-%m-%d -d "30 days ago")

#directoris to backup 
SRCDIR="/data/"
SRCDIR2="/home/"

#where to storage the backups
BACKUPDIR="/data/storage_branches/data/$DAY0"
BACKUPDIR2="/data/storage_branches/home/$DAY0"

#hostname or IP address of rsync remote 
REMOTE="192.168.1.100"
USER="root"

#link destination directory:
LINK="/data/storage_branches/data/$DAY1"
LINK2="/data/storage_branches/home/$DAY1"

#limit bandwidth rsync uses in its network communications
BWLIMIT='' #KByte/s

#exclude file
EXCLUDE="/data/scripts/rsync_exclude_branches"

#rsync options
OPT="--archive --one-file-system --hard-links --human-readable --inplace --numeric-ids --delete --delete-excluded --exclude-from=$EXCLUDE
--itemize-changes --recursive --whole-file --times --bwlimit=$BWLIMIT --log-file=$LOGDATA --link-dest=$LINK" OPT2="--archive --one-file-system
--hard-links --human-readable --inplace --numeric-ids --delete --delete-excluded --exclude-from=$EXCLUDE --itemize-changes --recursive --whole-file
--times --bwlimit=$BWLIMIT --log-file=$LOGHOME --link-dest=$LINK2"

        #delete the backup from 30 days ago, if it exists
        if [ -d /data/storage_branches/data/$DAY30 ]
            then
                rm /data/storage_branches/data/$DAY30 -r
                rm /data/storage_branches/home/$DAY30 -r
            else
                #find out if a directory exists or not
                if [ -d /data/storage_branches/data/$DAY1 ]
                        then
                        #sync data
                        rsync $OPT $USER@$REMOTE:$SRCDIR $BACKUPDIR
                        #sync home
                        rsync $OPT2 $USER@$REMOTE:$SRCDIR2 $BACKUPDIR2

                        #notify to system administrator
                        mail -s "Rsync branches data - Incremental backup finished" -a $LOGHOME -a $LOGDATA -r $MAILFROM $MAILADMIN

                                else

                        #create a link directory using hard link (in case a public holidays)
                        cp -al $DAY2 $DAY1

                        #sync data
                        rsync $OPT $USER@$REMOTE:$SRCDIR $BACKUPDIR
                        #sync home
                        rsync $OPT2 $USER@$REMOTE:$SRCDIR2 $BACKUPDIR2

                        #notify to system administrator
                        mail -s "Alert: Rsync branches data - $DAY1 Directory not found and script auto created hard link" -r $MAILFROM $MAILADMIN
                fi
        fi
exit 0;
# End Of Script
