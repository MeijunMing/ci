#!/bin/bash
set -e
JENKINS_NAME=${JENKINS_NAME:-jenkins}
JENKINS_VOLUME=${JENKINS_VOLUME:-jenkins-volume}
GERRIT_NAME=${GERRIT_NAME:-gerrit}
JENKINS_IMAGE_NAME=${JENKINS_IMAGE_NAME:-jenkins}
JENKINS_OPTS=${JENKINS_OPTS:---prefix=/jenkins}

# Stop and delete jenkins container.
docker stop ${JENKINS_NAME}
docker rm ${JENKINS_NAME}

# Start Jenkins.
docker run \
--name ${JENKINS_NAME} \
--link ${GERRIT_NAME}:gerrit \
-p 50000:50000 \
--volumes-from ${JENKINS_VOLUME} \
-d ${JENKINS_IMAGE_NAME} ${JENKINS_OPTS}
