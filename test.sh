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
    parent=$fileName
    mkdir $parent
  elif [ "$grade" == "##" ]
  then
    fileGrade=2
  fi

  if [ $fileGrade -eq 1 ]
  then
    touch ${parent}/README.md
  elif [ $fileGrade -eq 2 ]
  then
    touch ${parent}/${fileName}.md
  fi
done < README.md
