#/bin/bash
###------------------------------------------------------------------------------
# Path to Trash directory

TrashPath=~/.local/share/Trash
# never delete files less than 15 days old
FileTime=15 
DirTime=15
InfoTime=15

  find "$TrashPath/files" -maxdepth 1 -type f -ctime +$FileTime -execdir rm -f '{}' +
	find "$TrashPath/files" -maxdepth 1 -type d -ctime +$DirTime -execdir rm -rf '{}' +
	find "$TrashPath/info" -maxdepth 1 -type f -ctime +$InfoTime -execdir ls '{}' + |sed -e 's/.\///' |sed -e 's/.trashinfo$//' > /tmp/emptytrash_trashinfo.list
    while read line
    do
      ls "$TrashPath/files/${line}" > /dev/null 2>&1
      if [ $? -ne 0 ]
      then
        rm -rf "$TrashPath/info/${line}.trashinfo"
      fi
    done < /tmp/emptytrash_trashinfo.list
    rm -rf /tmp/emptytrash_trashinfo.list
###------------------------------------------------------------------------------
