#!/bin/bash

fileGrade=1
yourFather=piggy

if [ $# -eq 2 ]; then
  project=$1
  config=$2
elif [ $# -eq 1 ]; then
  project=$1
  config="$1/config"
elif [ $# -eq 0 ]; then
  project="./"
  config="config"
else
  echo "usage: ./gitbookProjectAutoMake [project_path] [config_file_path]"
fi

if [ ! -d ${project} ]; then
  echo "the project directory does not exist!"
  exit 1
fi

if [ ! -f ${config} ]; then 
  echo "the config file does not exist!"
  exit 1
fi

summaryFile="${project}/SUMMARY.md"
readmeFile="README.md"

touch ${summaryFile}
echo "make the SUMMARY.md"
echo -e "# SUMMARY\n" > ${summaryFile}
echo ""

while read line
do
  grade=`echo ${line} | awk '{print $1}'`
  title=`echo ${line} | awk '{print $2}'`
  fileName=`echo ${line} | awk '{print $3}'`

  echo -e "grade:${grade}\ttitle:${title}\tfileName:${fileName}"

  if [ "$grade" == "#" ]
  then
    fileGrade=1
  elif [ "$grade" == "##" ]
  then
    fileGrade=2
    echo "parent: ${yourFather}"
  fi

  if [ $fileGrade -eq 1 ]
  then
    if [ "$fileName" == "README" ]
    then
      if [ ! -f ${project}${readmeFile} ]; then
        touch ${project}${readmeFile}
        echo "# $title" > ${project}${readmeFile}
        echo "make a new file ------- ${project}${readmeFile}"
      else
        sed -i "1c # ${title}" ${project}${readmeFile}
        echo -e "${project}${readmeFile} is existed!\nupdate the title of ${project}${readmeFile}"
      fi

      echo "* [${title}](${readmeFile})" >> $summaryFile
      echo "add \"* [${title}](${readmeFile})\" into SUMMARY.md"
    else
      yourFather=$fileName
      if [ ! -d ${project}${yourFather} ]; then
        mkdir ${project}${yourFather}
        echo "make a new directory -- ${project}${yourFather}"
      else
        echo "${project}${yourFather} is existed!"
      fi

      if [ ! -f ${project}${yourFather}/${readmeFile} ]; then
        touch ${project}${yourFather}/${readmeFile}
        echo "# $title" > ${project}${yourFather}/${readmeFile}
        echo "make a new file ------- ${project}${yourFather}/${readmeFile}"
      else
        sed -i "1c # ${title}" ${project}${yourFather}/${readmeFile}
        echo -e "${project}${yourFather}/${readmeFile} is existed!\nupdate the title of ${project}${yourFather}/${readmeFile}"
      fi
      echo "* [${title}](${fileName}/README.md)" >> $summaryFile
      echo "add \"* [${title}](${fileName}/${readmeFile})\" into SUMMARY.md"
    fi
  elif [ $fileGrade -eq 2 ]
  then
    if [ ! -f "${project}${yourFather}/${fileName}.md" ]; then
      touch ${project}${yourFather}/${fileName}.md
      echo "# $title" > ${project}${yourFather}/${fileName}.md
      echo "make a new file ------- ${project}${yourFather}/${fileName}.md"
    else
      sed -i "1c # ${title}" ${project}${yourFather}/${fileName}.md
      echo -e "${project}${yourFather}/${fileName}.md is existed!\nupdate the title of ${project}${yourFather}/${fileName}.md"
    fi
    echo "  * [${title}](${yourFather}/${fileName}.md)" >> $summaryFile
    echo "add \"  * [${title}](${yourFather}/${fileName}.md)\" into SUMMARY.md"
  fi

    echo ""
done < $config

echo "finish"
