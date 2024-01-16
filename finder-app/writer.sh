#!/bin/bash

if [[ $# != 2 ]]
then
	echo -e "Please provide two arguments, e.g.: ./writer.sh /path/to/writefile text-to-be-writen, where\n\r\tFirst argument is the path to file\n\r\tSecond argument is a text to be saved to this file."
	exit 1
fi

if [ -f $1 ]
then
	echo "$2" > $1
else
	pathtocheck=$(echo "$1" | tr / " ")
	levels=$(echo "$pathtocheck" | wc -w)
	temppath=""
	for ((i=1 ; i < $((levels)) ; i++)); do
		temppath="$temppath/$(echo "$pathtocheck" | cut -d " " -f $((i+1)))"
		if ! [ -d $temppath ]
		then
			mkdir $temppath
			if [[ $? != 0 ]]
			then
				echo "Directory $temppath count not be created. Exiting with error code 1."
				exit 1
			fi
		fi
	done
	touch $1
	if [[ $? != 0 ]]
	then
		echo "File could not be created. Exiting with error code 1."
		exit 1
	else
		echo "$2" > $1
	fi
fi
