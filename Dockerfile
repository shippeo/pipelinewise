FROM python:3.7.4-buster
LABEL maintainer="Shippeo"

RUN apt-get -qq update && apt-get -qqy install \
    apt-utils \
    alien \
    libaio1 \
    && pip install --upgrade pip 

COPY . /app

RUN cd /app \
    && ./install.sh --acceptlicenses --nousage --notestextras \
    && ln -s /root/.pipelinewise /app/.pipelinewise

RUN mkdir -p /app/wrk

WORKDIR /app/wrk
