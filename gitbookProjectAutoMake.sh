#!/bin/bash

fileGrade=1
parent=piggy

touch SUMMARY.md
summaryFile="SUMMARY.md"

echo -e "# SUMMARY\n" > $summaryFile

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
      if [ ! -f "README.md" ]; then
        touch README.md
        echo "# $title" > README.md
      else
        sed -i "1c # ${title}" README.md
      fi
    else
      parent=$fileName
      if [ ! -d ${parent} ]; then
        mkdir $parent
      fi
      if [ ! -f "${parent}/README.md" ]; then
        touch ${parent}/README.md
        echo "# $title" > ${parent}/README.md
      else
        sed -i "1c # ${title}" ${parent}/README.md
      fi
      echo "* [${title}](${fileName}/README.md)" >> $summaryFile
    fi
  elif [ $fileGrade -eq 2 ]
  then
    if [ ! -d "${parent}/${fileName}.md" ]; then
      touch ${parent}/${fileName}.md
      echo "# $title" > ${parent}/${fileName}.md
    else
      sed -i "1c # ${title}" ${parent}/${fileName}.md
    fi
    echo "  * [${title}](${parent}/${fileName}.md)" >> $summaryFile
  fi
done < config
