#!/bin/bash
chown jenkins: $JENKINS_HOME $JENKINS_LOGS
/etc/init.d/jenkins start || true
