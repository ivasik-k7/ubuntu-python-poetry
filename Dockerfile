FROM ubuntu:jammy

ENV HOME /root
ENV DEBIAN_FRONTEND=noninteractive

USER root
WORKDIR /root

ARG PYTHON_VERSION=3.11

ENV PYTHON_ROOT ${HOME}/local/python${PYTHON_VERSION}
ENV PATH $PYTHON_ROOT/bin:${PATH}
ENV POETRY_HOME ${HOME}/.local/share/pypoetry

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-811
ENV TZ=Europe/London

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update

RUN apt-get install -y sudo software-properties-common && \
    sudo apt update && \
    sudo add-apt-repository ppa:deadsnakes/ppa && \
    sudo apt update


RUN sudo apt install -y --no-install-recommends \
    ## Core Utils Related 
    ca-certificates vim sudo make \
    tree wget git curl bash-completion \
    ## Python related
    python${PYTHON_VERSION} \
    python${PYTHON_VERSION}-venv \
    python${PYTHON_VERSION}-dev && \
    ## Autoclean Related
    sudo apt-get -y autoclean && \
    sudo apt-get -y autoremove && \
    sudo rm -rf /var/lib/apt/lists/* && \
    ## Allias related
    alias python=python3

## Install PIP
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3
## Install Poetry
RUN curl -sSL https://install.python-poetry.org | POETRY_HOME=${POETRY_HOME} python3


CMD [ "/bin/bash" ]