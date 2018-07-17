FROM node:8.11

RUN echo "alias ll='ls $LS_OPTIONS -l --color=auto'" >> /root/.bashrc

# Install java
RUN apt-get update -q \
    && apt-get install -y software-properties-common \
    && add-apt-repository "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" \
    && apt-get update \
    && echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
    && echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections \
    && apt-get install -y oracle-java8-installer

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle/

# Install node dependencies
RUN npm set progress=false \
    && npm install -g \
        typescript@2.8.1 \
        ionic@3.20.0 \
        cordova@8.0.0 \
    && npm cache clear --force

# Install android tools
RUN dpkg --add-architecture i386 \
    && apt-get update -q \
    && apt-get install -y libc6:i386 libstdc++6:i386 libz1:i386 unzip

RUN mkdir /opt/android-sdk-linux && cd /opt/android-sdk-linux \
    && wget -q https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip \
    && unzip -q sdk-tools-linux-3859397.zip \
    && rm sdk-tools-linux-3859397.zip

ENV ANDROID_HOME /opt/android-sdk-linux

RUN yes | /opt/android-sdk-linux/tools/bin/sdkmanager --licenses
RUN yes | /opt/android-sdk-linux/tools/bin/sdkmanager "platforms;android-21" "build-tools;21.1.2"

RUN cd /opt \
    && wget -q https://services.gradle.org/distributions/gradle-4.7-bin.zip \
    && unzip -q gradle-4.7-bin.zip \
    && rm gradle-4.7-bin.zip

ENV GRADLE_HOME /opt/gradle-4.7

ENV PATH ${PATH}:${GRADLE_HOME}/bin:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

# cleanup
RUN apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*