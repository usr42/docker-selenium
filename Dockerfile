FROM ubuntu:17.10
RUN echo RUN \
    && apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y \
      inetutils-ping \
      net-tools \
      vim \
    && rm -rf /var/lib/apt/lists/*
CMD bash
