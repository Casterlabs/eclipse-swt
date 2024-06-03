#!/bin/bash

FILE=$1
SRC=$2
ARTIFACT_ID=$3
VERSION=$4

DIR=`pwd`/maven

mvn deploy:deploy-file \
		-Durl=file:/$DIR \
		-Dsources=$SRC \
		-Dfile=$FILE \
		-DgroupId=org.eclipse.swt \
		-DartifactId=$ARTIFACT_ID \
		-Dversion=$VERSION \
        -Dpackaging=jar \
        -DgeneratePom=true