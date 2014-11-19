#!/bin/bash
	
if [ "$2" != "" ]
then COMMENT="$2"
else COMMENT=`git rev-parse head`
fi

echo $COMMENT | xargs gh is $1 --comment
gh is $1 --close