FROM m3hran/baseimage:latest
MAINTAINER Martin Taheri <m3hran@gmail.com>
LABEL Description="Jenkins CI Image"

ENV JENKINS_HOME /jenkins
ENV JENKINS_LOGS /var/log/jenkins

# Install required jenkins and docker packages
RUN clean_install.sh default-jdk apt-transport-https ca-certificates software-properties-common \
    make


# Install docker apt repo 
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
# Install docker
RUN clean_install.sh docker-ce

# Install docker-compose
RUN curl -L https://github.com/docker/compose/releases/download/1.17.0/docker-compose-`uname -s`-`uname -m` \
    -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

# Set JAVA_HOME
RUN echo JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java" >> /etc/environment

# Install Jenkins
RUN wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | apt-key add -
RUN echo deb http://pkg.jenkins.io/debian-stable binary/ | tee /etc/apt/sources.list.d/jenkins.list
RUN clean_install.sh jenkins 
RUN mkdir $JENKINS_HOME 
RUN chown jenkins: $JENKINS_HOME $JENKINS_LOGS

# Ensure Jenkins service startups
COPY ./resources/jenkins_start.sh /etc/my_init.d/
COPY ./resources/jenkins.default /etc/default/jenkins
RUN chmod +x /etc/my_init.d/jenkins_start.sh

EXPOSE 8080
WORKDIR $JENKINS_HOME


