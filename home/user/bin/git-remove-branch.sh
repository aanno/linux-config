#!/bin/bash 

for i in $*; do
	BRANCH="$i"
	echo "git push origin :$BRANCH"
	echo "git branch -D $BRANCH"
	read -p "Really sure (y/N/eXit)?:" IN 
	if [ "$IN" == "y" ]; then 
		git push origin :"$BRANCH" && \
		git branch -D "$BRANCH" && \
		echo "Deleted $BRANCH" || \
		echo "Some went wrong deleting $BRANCH"
	elif [ "$IN" == "x" ]; then
		echo "Abort as requested"
		exit -1
	else
		echo "Skip $BRANCH"
	fi
done
