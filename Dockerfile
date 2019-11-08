FROM python:3.7.4-buster
LABEL maintainer="Shippeo"

ARG PIPELINEWISE_HOME=/app

RUN apt-get -qq update && apt-get -qqy install \
        apt-utils \
        alien \
        libaio1 \
    && pip install --upgrade pip \
    && useradd -ms /bin/bash -d ${PIPELINEWISE_HOME} pipelinewise

COPY . /app

RUN chown -R pipelinewise: /app

RUN groupadd docker -g 999
RUN groupadd airflow -g 6666
RUN usermod -aG docker,airflow pipelinewise

USER pipelinewise

RUN mkdir -p ${PIPELINEWISE_HOME}

WORKDIR ${PIPELINEWISE_HOME}

RUN cd /app \
    && ./install.sh --acceptlicenses --nousage --notestextras 

ENTRYPOINT ["/app/entrypoint.sh"]
