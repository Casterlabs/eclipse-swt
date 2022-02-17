#!/bin/bash


# Full URL Format:
# https://mirror.umd.edu/eclipse/eclipse/downloads/drops4/R-4.22-202111241800/swt-4.22-win32-win32-x86_64.zip


MIRROR='https://mirror.umd.edu/eclipse/eclipse/downloads/drops4/'

IFS=$'\n'
to_download=`grep "^[^#;]" urls.txt`

for item in $to_download;
do
    filename=`echo $item | cut -d "/" -f2`
    itemName=${filename::${#filename}-4}

    echo ------------------------

    if [ -d cache/$itemName ] 
    then
        echo Skipping $itemName
    else
        echo Downloading $itemName

        mkdir cache/$itemName
        wget -O cache/$filename $MIRROR$item
        unzip -d cache/$itemName cache/$filename
        rm cache/$filename

        version=`echo $itemName | cut -d "-" -f2`
        artifactId=`echo $itemName | cut -d "-" -f3`.`echo $itemName | cut -d "-" -f4`.`echo $itemName | cut -d "-" -f5`

        echo Installing $artifactId:$version

        sh install.sh "cache/$itemName/swt.jar" "cache/$itemName/src.zip" $artifactId $version 
    fi;
done;