#!/bin/bash

#starting file location
#ogSavefile=/home/jadesstars/.local/share/Steam/steamapps/compatdata/2944813683/pfx/dosdevices/c:/users/steamuser/AppData/Roaming/EldenRing/76561198060893316/ER0000.sl2

#testing filepath for ertool location this one right here (below is correct)
#ogSavefile=/home/jadesstars/.local/share/Steam/steamapps/compatdata/2944813683/pfx/drive_c/users/steamuser/AppData/Roaming/EldenRing/76561198060893316/ER0000.sl2
#testno2 ERtool save file locations

#starting location for testing purposes only
#ogSavefile=$HOME/test.txt

echo -e "if this is the first time you have ever run this, this is the location of EldenRing save files, open elden ring, drop an item to force the game to update the save files, then reopen this immediately after\n"
#makes the directory where the script and supporting files will be stored if it doesnt exist (assuming people will run it from their downloads folder)
if [ ! -e $HOME/savestatescriptFolder/EldenRingSaveStates ]; then
	mkdir -p $HOME/savestatescriptFolder/EldenRingSaveStates
	scriptPdir=$HOME/savestatescriptFolder
	saveStates=$HOME/savestatescriptFolder/EldenRingSaveStates
	scriptFile=$(find $HOME/ -type f -name savestatescript2.sh 2>/dev/null)
	cp $scriptFile $scriptPdir/
	sleep 5s
else
	scriptPdir=$HOME/savestatescriptFolder
	saveStates=$scriptPdir/EldenRingSaveStates
	scriptFile=$(find $HOME/ -type f -name savestatescript2.sh 2>/dev/null)
fi

findFileLocation=$(find / -name ER000* -mmin -5 > $scriptPdir/saveFileScript.txt 2>/dev/null)
#chmod u+rw $findFileLocation
echo "locating your EldenRing Save files"
$findFileLocation
sleep 3s
echo -e "\n"

ogSavefile=$(grep -v .bak $scriptPdir/saveFileScript.txt 2>/dev/null)
#folder containing savestates as desired
#chmod u+rw $ogSavefile
echo "savefile found!"
#echo $ogSavefile
while [ : ]; do
	echo "to close this (q)"
	echo "are you lo(a)ding a save, or (c)apturing a new one?"
	read i
	if [ $i == c ]; then
		echo "gib name of savestate"
		ls -l $saveStates
		read newName
		cp $ogSavefile $saveStates/$newName
		echo "savestate captured as $newName"
	elif [ $i == a ]; then
		echo "choose a save to load"
		ls -l $saveStates
		read fileN
		cp $saveStates/$fileN $ogSavefile
		echo "savestate loaded and ready to go"
	elif [ $i == q ]; then
		echo "exiting the program, k thanks bye"
		break
	else
		echo "try a valid option, bye"
	fi
echo -e "\n"
#if this was opened in terminal then it should just restart unless you closed it with q input
done
