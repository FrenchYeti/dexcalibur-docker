FROM ubuntu:16.04
MAINTAINER @FrenchYeti "frenchyeti@protonmail.com"

RUN useradd -ms /bin/bash dexcalibur


# support multiarch: i386 architecture
# install Java
# install essential tools
# install Nodejs
RUN dpkg --add-architecture i386 && \
    apt-get update -y && \
    apt-get install -y libncurses5:i386 libc6:i386 libstdc++6:i386 lib32gcc1 lib32ncurses5 lib32z1 zlib1g:i386 && \
    apt-get install -y --no-install-recommends openjdk-8-jdk && \
    apt-get install -y git wget zip curl

RUN	curl -sL https://deb.nodesource.com/setup_11.x  | bash -
RUN apt-get update -y && \
	apt-get install -y nodejs && \
	nodejs -v && \
	npm -v

# download and install Gradle
# https://services.gradle.org/distributions/
ARG GRADLE_VERSION=4.10.3
RUN cd /opt && \
    wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip && \
    unzip gradle*.zip && \
    ls -d */ | sed 's/\/*$//g' | xargs -I{} mv {} gradle && \
    rm gradle*.zip


# download and install Android SDK
# https://developer.android.com/studio/#downloads
ARG ANDROID_SDK_VERSION=4333796
RUN mkdir -p /opt/android-sdk && cd /opt/android-sdk && \
    wget -q https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip && \
    unzip *tools*linux*.zip && \
    rm *tools*linux*.zip


# set the environment variables
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV GRADLE_HOME /opt/gradle
ENV ANDROID_HOME /opt/android-sdk
ENV PATH ${PATH}:${GRADLE_HOME}/bin:${ANDROID_HOME}/emulator:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools/bin
ENV _JAVA_OPTIONS -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap

# accept the license agreements of the SDK components
# ADD license_accepter.sh /opt/
# RUN /opt/license_accepter.sh $ANDROID_HOME

# setup adb and dexcalibur server
EXPOSE 5037 8000 31415


# install and configure SSH server
# EXPOSE 22
# ADD sshd-banner /etc/ssh/
# ADD authorized_keys /tmp/
# RUN apt-get update -y && \
#   apt-get install -y openssh-server supervisor locales && \
#   mkdir -p /var/run/sshd /var/log/supervisord && \
#   locale-gen en en_US en_US.UTF-8 && \
#   FILE_SSHD_CONFIG="/etc/ssh/sshd_config" && \
#   echo "\nBanner /etc/ssh/sshd-banner" >> $FILE_SSHD_CONFIG && \
#   echo "\nPermitUserEnvironment=yes" >> $FILE_SSHD_CONFIG && \
#   ssh-keygen -q -N "" -f /root/.ssh/id_rsa && \
#   FILE_SSH_ENV="/root/.ssh/environment" && \
#   touch $FILE_SSH_ENV && chmod 600 $FILE_SSH_ENV && \
#   printenv | grep "JAVA_HOME\|GRADLE_HOME\|KOTLIN_HOME\|ANDROID_HOME\|LD_LIBRARY_PATH\|PATH" >> $FILE_SSH_ENV && \
#   FILE_AUTH_KEYS="/root/.ssh/authorized_keys" && \
#   touch $FILE_AUTH_KEYS && chmod 600 $FILE_AUTH_KEYS && \
#   for file in /tmp/*.pub; \
#   do if [ -f "$file" ]; then echo "\n" >> $FILE_AUTH_KEYS && cat $file >> $FILE_AUTH_KEYS && echo "\n" >> $FILE_AUTH_KEYS; fi; \
#   done && \
#   (rm /tmp/*.pub 2> /dev/null || true)
# ADD supervisord.conf /etc/supervisor/conf.d/
# CMD ["/usr/bin/supervisord"]


# Install android tools + sdk
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH $PATH:${ANDROID_HOME}/tools:$ANDROID_HOME/platform-tools

# Install APKTool
RUN mkdir -p /home/dexcalibur/tools/apktool && \
	cd /home/dexcalibur/tools/apktool && \
	wget -q https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool && \
	wget -q https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.4.0.jar && \
	mv *.jar apktool.jar && \
	mv apktool* /usr/local/bin/. && \
	chmod +x /usr/local/bin/apktool*
	

# RUN wget -qO- "http://dl.google.com/android/android-sdk_r24.3.4-linux.tgz" | tar -zx -C /opt && \
#     echo y | android update sdk --no-ui --all --filter platform-tools --force

# Setup Dexcalibur
WORKDIR /home/dexcalibur

RUN git clone https://github.com/FrenchYeti/dexcalibur.git && \
	cd /home/dexcalibur/dexcalibur && \
	/usr/bin/npm install
	
ADD files/config.js dexcalibur/config.js

# install platform-tools
RUN mkdir /home/dexcalibur/platform-tools/ && \ 
	cd /home/dexcalibur/platform-tools/ && \
	wget -q https://dl.google.com/android/repository/platform-tools-latest-linux.zip && \
	unzip *.zip && \
	rm *.zip 

# Port forwarding required by dexcaliburs
RUN echo 'adb forward tcp:31415 tcp:31415' >> /home/dexcalibur/.bashrc

WORKDIR /home/dexcalibur/dexcalibur
VOLUME ["/home/dexcalibur/workspace"]
ENTRYPOINT ["/home/dexcalibur/dexcalibur/dexcalibur"]
