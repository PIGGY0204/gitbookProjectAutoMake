#!/bin/bash

log() {
    case $1 in
    INFO)
	echo "INFO $2"
	;;
    ERROR)
        echo "ERROR $2"
	exit 1
	;;
    esac
}

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
  log ERROR "usage:./gitbookProjectAutoMake [project_path] [config_file_path]"
fi

if [ ! -d ${project} ]; then
  mkdir $project
  log INFO "mkdir:make the project"
fi

if [ ! -f ${config} ]; then 
  log ERROR "config:can not find config"
fi

summaryFile="${project}/SUMMARY.md"
readmeFile="README.md"

touch ${summaryFile}
echo -e "# SUMMARY\n" > ${summaryFile}

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
      if [ ! -f ${project}${readmeFile} ]; then
        touch ${project}${readmeFile}
        echo "# $title" > ${project}${readmeFile}
        log INFO "touch:${project}${readmeFile}"
      else
        sed -i "1c # ${title}" ${project}${readmeFile}
        log INFO "title:\"${title}\" > ${project}${readmeFile}"
      fi
      echo "* [${title}](${readmeFile})" >> $summaryFile
    else
      yourFather=$fileName
      if [ ! -d ${project}${yourFather} ]; then
        mkdir ${project}${yourFather}
        log INFO "mkdir:${project}${yourFather}"
      fi

      if [ ! -f ${project}${yourFather}/${readmeFile} ]; then
        touch ${project}${yourFather}/${readmeFile}
        echo "# $title" > ${project}${yourFather}/${readmeFile}
        log INFO "touch:${project}${yourFather}/${readmeFile}"
      else
        sed -i "1c # ${title}" ${project}${yourFather}/${readmeFile}
        log INFO "title:\"${title}\" > ${project}${yourFather}/${readmeFile}"
      fi
      echo "* [${title}](${fileName}/README.md)" >> $summaryFile
    fi
  elif [ $fileGrade -eq 2 ]
  then
    if [ ! -f "${project}${yourFather}/${fileName}.md" ]; then
      touch ${project}${yourFather}/${fileName}.md
      echo "# $title" > ${project}${yourFather}/${fileName}.md
      log INFO "touch:${project}${yourFather}/${fileName}.md"
    else
      sed -i "1c # ${title}" ${project}${yourFather}/${fileName}.md
      log INFO "title:\"${title}\" > ${project}${yourFather}/${fileName}.md"
    fi
    echo "  * [${title}](${yourFather}/${fileName}.md)" >> $summaryFile
  fi
done < $config

echo ""
cat $summaryFile

echo ""
tree $project

echo -e "\nfinish"
