FROM m3hran/docker-baseimage:latest
MAINTAINER Martin Taheri <m3hran@gmail.com>
LABEL Description="Jenkins CI Image"

ENV JENKINS_HOME /jenkins


# Install Packanges and Cleanup APT cache 
RUN clean_install.sh default-jdk

# Set JAVA_HOME
RUN echo JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java" >> /etc/environment

# Install Jenkins
RUN wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | apt-key add -
RUN echo deb http://pkg.jenkins.io/debian-stable binary/ | tee /etc/apt/sources.list.d/jenkins.list
RUN clean_install.sh jenkins 
RUN mkdir $JENKINS_HOME

# Ensure Jenkins service startups
COPY ./resources/jenkins_start.sh /etc/my_init.d/
RUN chmod +x /etc/my_init.d/jenkins_start.sh

EXPOSE 8080
WORKDIR $JENKINS_HOME

