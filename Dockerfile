FROM node:6-stretch
MAINTAINER Petr Sloup <petr.sloup@klokantech.com>

USER root

ENV NODE_ENV="production"
VOLUME /data
WORKDIR /data
EXPOSE 8080

RUN apt-get -qq update \
&& DEBIAN_FRONTEND=noninteractive apt-get -y install \
    apt-transport-https \
    curl \
    unzip \
    build-essential \
    python \
    libcairo2-dev \
    libgles2-mesa-dev \
    libgbm-dev \
    libllvm3.9 \
    libprotobuf-dev \
    libxxf86vm-dev \
    xvfb \
&& apt-get clean

RUN mkdir -p /usr/src/app
COPY ./ /usr/src/app


#COPY ./data /data
RUN chown -R 1001:0 /data && \
  chmod -R g+rwX /data && chmod -R 777 /data

RUN cd /usr/src/app && npm install --production

RUN chown -R 1001:0 /usr/src/app && \
  chmod -R g+rwX /usr/src/app && chmod -R 777 /usr/src/app

USER 1001


#ENTRYPOINT ["node", "/usr/src/app/", "-p", "8080", "--mbtiles","/data/osm-2018-11-12-v3.8-us_virginia.mbtiles"]
ENTRYPOINT ["node", "/usr/src/app/", "-p", "8080"]
