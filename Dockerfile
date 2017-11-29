# firefox:v0.7
FROM ubuntu:17.10
ADD xvfb.init /etc/init.d/xvfb
RUN echo RUN \
    && chmod +x /etc/init.d/xvfb \
    && update-rc.d xvfb defaults \
    && apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y \
      dbus \
      firefox \
      git \
      inetutils-ping \
      openjdk-8-jdk-headless \
      vim \
      xvfb \
    && dbus-uuidgen >/etc/machine-id \
    && apt-get remove --purge -y \
      dbus \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd -g 1001 jenkins \
    && useradd -u 1001 -g 1001 -d /home/jenkins -m -s /bin/bash jenkins
ENV DISPLAY=:10
CMD (su - jenkins -c "/etc/init.d/xvfb start"; bash)
