FROM ubuntu:14.04

MAINTAINER Henrik Nilsson <henrik.nilsson@bytequest.se>

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update
RUN apt-get install -yq --no-install-recommends software-properties-common
RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get update
RUN apt-get install -yq --no-install-recommends lib32stdc++6 lib32z1
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN apt-get install -yq --no-install-recommends oracle-java7-installer
# Export JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle

# Install android sdk
# Environment variables
ENV ANDROID_HOME /opt/android-sdk
ENV PATH $PATH:$ANDROID_HOME/tools
ENV PATH $PATH:$ANDROID_HOME/platform-tools
ENV PATH $PATH:$GRADLE_HOME/bin

RUN wget http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz
RUN tar -xvzf android-sdk_r24.4.1-linux.tgz
RUN mv android-sdk-linux $ANDROID_HOME
RUN rm android-sdk_r24.4.1-linux.tgz

# Install Android tools
RUN echo y | $ANDROID_HOME/tools/android update sdk --filter platform-tools,android-23,build-tools-23.0.1,build-tools-23.0.2,extra-android-m2repository,extra-android-support,extra-google-m2repository --no-ui -a

