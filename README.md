so I got tired of the save file organizer not running properly with the linux environment created by using cheatengine/ERTool in conjunction with linux. it should run from your downloads file just fine
but it does create a folder in your home directory ($HOME) which means that if you like running things from command line, its only a couple of keypresses away.
Otherwise you will have to open file explorer right-click and select run in terminal, or make a desktop shortcut and still right-click and run in terminal.
    
    ~
If you for some reason select the wrong ER0000.sl2 file, fear not I made it simple for the script to function
    simply open your terminal/command prompt of choice and paste this:

    rm -f $HOME/savestatescriptFolder/saveFileScript.txt
then you re-run the script and choose one of the other options that are presented to you, repeat until you have the correct game files, or manually type it if it isnt show in the list of available options.
