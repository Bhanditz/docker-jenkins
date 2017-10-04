#!/bin/bash
chown jenkins: $JENKINS_HOME
/etc/init.d/jenkins start || true
