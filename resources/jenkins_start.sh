#!/bin/bash
chown jenkins: $JENKINS_HOME $JENKINS_LOGS
groupadd -g $DOCKER_HOST_GID docker_host
usermod -aG docker_host jenkins
/etc/init.d/jenkins start || true
