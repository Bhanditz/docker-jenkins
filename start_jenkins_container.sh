#!/bin/bash
docker run -d -p 80:8080 -v /home/cent/jenkins-home:/jenkins --name jenkins my-jenkins
