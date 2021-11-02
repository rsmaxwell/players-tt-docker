#!/bin/bash

ENDPOINT="https://server.rsmaxwell.co.uk/archiva/repository"
REPOSITORY="releases"
GROUP="com.rsmaxwell.players"
ARTIFACT="players-tt"
PACKAGING="zip"

BASE="${ENDPOINT}/${REPOSITORY}/${GROUP//.//}/${ARTIFACT}"

wget --quiet ${BASE}/maven-metadata.xml
result=$?
if [ ! ${result} == 0 ]; then
    echo "Error: $0[${LINENO}]"
    echo "result: ${result}"
    exit 1
fi

line=$(grep release maven-metadata.xml)

regex="<release>(.*)</release>"
if [[ ! ${line} =~ ${regex} ]]; then
    echo "Error: $0[${LINENO}]"
    exit 1
fi

set -x

version="${BASH_REMATCH[1]}"
FILENAME="${ARTIFACT}-${version}.zip"

echo "downloading ${FILENAME}"

rm -rf maven-metadata.xml ${ARTIFACT}-*.zip*

echo "'/tmp' before wget"
ls -al /tmp

rm -rf /tmp/${FILENAME}

wget --quiet ${BASE}/${version}/${FILENAME}
result=$?
if [ ! ${result} == 0 ]; then
    echo "Error: $0[${LINENO}]"
    echo "result: ${result}"
    exit 1
fi

echo "'/tmp' after wget"
ls -al /tmp

echo "'/usr/share/nginx/html' after wget"
ls -al /usr/share/nginx/html

unzip ${FILENAME}
result=$?
if [ ! ${result} == 0 ]; then
    echo "Error: $0[${LINENO}]"
    echo "result: ${result}"
    exit 1
fi

rm -rf ${FILENAME}