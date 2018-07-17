#!/bin/bash

CWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd ${CWD}

source ../.env

VERSION=${IMAGE_VERSION}
REPO="petruisfan"
IMAGE="docker-ionic"


echo "Does the tag $REPO/$IMAGE:$VERSION need updating? [y,N]"

read ANSWER

if [[ ${ANSWER} == 'y' ]]; then
    echo "Update the tag and rerun the command"
    exit 0
fi

docker build --force-rm -t $REPO/$IMAGE:$VERSION . | tee docker-build-output.log
[[ $? != 0 ]] && echo "Build image failed " && exit 1;

echo "Upload $REPO/$IMAGE to docker repository? [y,N]"

read ANSWER

if [[ ${ANSWER} == 'y' ]]; then
    docker push $REPO/$IMAGE:$VERSION
fi
