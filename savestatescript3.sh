#!/bin/bash

echo -e "if this is the first time you have ever run this, the location of you rsave files need to be found, this will find all of them for you, \nand if you need to check you can copy these file paths down in a txt document before selecting one of them.\nFor all future uses of this script you can either directly type into terminal, use it from the folder that gets made in your home directory, or just keep using it from downloads folder, whatever is easiest for you."
#makes the directory where the script and supporting files will be stored if it doesnt exist (assuming people will run it from their downloads folder)
if [ ! -e $HOME/savestatescriptFolder/EldenRingSaveStates ]; then
	mkdir -p $HOME/savestatescriptFolder/EldenRingSaveStates
	scriptPdir=$HOME/savestatescriptFolder
	saveStates=$HOME/savestatescriptFolder/EldenRingSaveStates
	scriptFile=$(find $HOME/ -type f -name savestatescript3.sh 2>/dev/null)
	cp $scriptFile $scriptPdir/
	sleep 5s
else
	scriptPdir=$HOME/savestatescriptFolder
	saveStates=$scriptPdir/EldenRingSaveStates
	scriptFile=$(find $HOME/ -type f -name savestatescript3.sh 2>/dev/null)
fi

#this is the way that it checks to see if you have the script already configured, so you dont have to tell it where to look each time for your game saves
if [ ! -e $scriptPdir/saveFileScript.txt ]; then
	findFileLocation=$(find $HOME/.local/ -name "ER000*.sl*" | grep -v ER0*.*.bak | grep -v BACKUP > $scriptPdir/saveFileScript.txt 2>/dev/null)
	echo "locating your EldenRing Save files"
	$findFileLocation
	sleep 3s
	echo -e "\n"
	echo -e "savefile found!\n"
	echo -e "choose which of these are the correct savestate filepaths\n(assuming there is more than one. ez way is doubleclick then middle mouse click, enter\n"
	cat $scriptPdir/saveFileScript.txt
	read ogSavefile
	echo $ogSavefile > $scriptPdir/saveFileScript.txt
else
	ogSavefile=$(head -1 $scriptPdir/saveFileScript.txt)
	echo -e "your current save location is\n"
	echo $ogSavefile
fi
#this is where it does the work of allowing you to rename your savestates as you see fit when capturing or reloading, and ofc exiting the program.
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
