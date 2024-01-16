#!/bin/bash

if [[ $# != 2 ]]
then
	echo -e "Please provide two arguments, e.g.:\t./finder.sh /path/to/directory word-to-search\n\r\tFirst argument: path to folder to be searched\n\r\tSecond argument: Word to be searched."
	exit 1
fi

if ! [ -d $1 ]
then
	echo -e "This path does not exist!\n\r"
	exit 1
fi

cd $1
dirr=$(echo "$(pwd)/*")
lines=0
files=0

for file in $(find $1 -print); do
	if ! [ -d $file ]
	then
		linesInFile=$(grep -c $2 $file)
#		echo -e "in file $file there is $linesInFile lines $2.\n\r"
		if [ $linesInFile -ge 1 ]
		then
#			cat $file
			lines=$(($lines+$linesInFile))
			files=$(($files+1))
		fi
	fi
done
echo -e "The number of files are $files and the number of matching lines are $lines"
