#!/bin/bash

fileGrade=1
parent=piggy

while read line
do
  grade=`echo ${line} | awk '{print $1}'`
  title=`echo ${line} | awk '{print $2}'`
  fileName=`echo ${line} | awk '{print $3}'`

  if [ "$grade" == "#" ]
  then
    fileGrade=1
  elif [ "$grade" == "##" ]
  then
    fileGrade=2
  fi

  if [ $fileGrade -eq 1 ]
  then
    if [ "$fileName" == "README" ]
    then
      touch README.md
    else
      parent=$fileName
      mkdir $parent
      touch ${parent}/README.md
    fi
  elif [ $fileGrade -eq 2 ]
  then
    touch ${parent}/${fileName}.md
  fi
done < test.md
