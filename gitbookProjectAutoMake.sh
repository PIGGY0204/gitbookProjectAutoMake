#!/bin/bash

fileGrade=1
yourFather=piggy

touch SUMMARY.md
summaryFile="SUMMARY.md"
readmeFile="README.md"

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
      if [ ! -f $readmeFile ]; then
        touch $readmeFile
        echo "# $title" > $readmeFile
        echo "make a new file ------- $readmeFile"
      else
        sed -i "1c # ${title}" $readmeFile
        echo -e "${readmeFile} is exited!\nupdate the title of ${readmeFile}"
      fi
    else
      yourFather=$fileName
      if [ ! -d ${yourFather} ]; then
        mkdir $yourFather
        echo "make a new directory -- ${yourFather}"
      fi
      if [ ! -f "${yourFather}/$readmeFile" ]; then
        touch ${yourFather}/$readmeFile
        echo "# $title" > ${yourFather}/${readmeFile}
        echo "make a new file ------- ${yourFather}/${readmeFile}"
      else
        sed -i "1c # ${title}" ${yourFather}/${readmeFile}
        echo -e "${yourFather}/${readmeFile} is exited!\nupdate the title of ${yourFather}/${readmeFile}"
      fi
      echo "* [${title}](${fileName}/README.md)" >> $summaryFile
    fi
  elif [ $fileGrade -eq 2 ]
  then
    if [ ! -f "${yourFather}/${fileName}.md" ]; then
      touch ${yourFather}/${fileName}.md
      echo "# $title" > ${yourFather}/${fileName}.md
      echo "make a new file ------- ${yourFather}/${fileName}.md"
    else
      sed -i "1c # ${title}" ${yourFather}/${fileName}.md
      echo -e "${yourFather}/${fileName}.md is exited!\nupdate the title of ${yourFather}/${fileName}.md"
    fi
    echo "  * [${title}](${yourFather}/${fileName}.md)" >> $summaryFile
  fi
done < config

echo "end"
