FROM ubuntu:17.10
ADD xvfb.init /etc/init.d/xvfb
RUN echo RUN \
    && chmod +x /etc/init.d/xvfb \
    && update-rc.d xvfb defaults \
    && apt-get update \
    && apt-get install --no-install-suggests -y \
        wget \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y \
      google-chrome-stable \
      dbus \
      firefox \
      git \
      inetutils-ping \
      net-tools \
      openjdk-8-jdk-headless \
      vim \
      xvfb \
    && dbus-uuidgen >/etc/machine-id \
    && apt-get remove --purge -y \
      dbus \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm /etc/apt/sources.list.d/google-chrome.list \
    && groupadd -g 1001 jenkins \
    && useradd -u 1001 -g 1001 -d /home/jenkins -m -s /bin/bash jenkins
COPY wrap_chrome_binary /opt/bin/wrap_chrome_binary
RUN /opt/bin/wrap_chrome_binary
ENV DISPLAY=:10
CMD (su - jenkins -c "/etc/init.d/xvfb start"; bash)
