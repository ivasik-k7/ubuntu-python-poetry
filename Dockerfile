FROM ubuntu:jammy

ENV USER=developer
ENV GROUP=developers
ENV UID=1001 

ENV HOME /home/developer
ENV DEBIAN_FRONTEND=noninteractive

RUN groupadd -r ${GROUP} && \
    useradd -m -s /bin/bash -u $UID -r -g ${GROUP} ${USER}

WORKDIR $HOME

ARG PYTHON_VERSION=3.11

# Python environment variables
ENV PYTHON_ROOT ${HOME}/local/python${PYTHON_VERSION}
ENV PATH $PYTHON_ROOT/bin:${HOME}/.local/bin:${PATH}
ENV POETRY_HOME ${HOME}/.local/share/pypoetry

# Localization and timezone
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-811
ENV TZ=Europe/London

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install sudo and other necessary packages
RUN apt-get update && apt-get install -y sudo

RUN apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt update

# Install the necessary packages
RUN apt install -y --no-install-recommends \
    ## Core Utils Related 
    ca-certificates vim sudo make gnupg \
    tree wget git curl bash-completion \
    ## Python related
    python${PYTHON_VERSION} \
    python${PYTHON_VERSION}-venv \
    python${PYTHON_VERSION}-dev && \
    ## Autoclean Related
    apt-get -y autoclean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/* && \
    ## Symbolic Link related
    ln -s /usr/bin/python${PYTHON_VERSION} /usr/bin/python

# Installing Python Related Managers
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3
RUN pip install poetry

# Configure sudoers for the developer user
RUN echo "developer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers   

# Change ownership with permissions of the home directory to the developer user
RUN chown -R $USER:$GROUP $HOME && \
    chmod -R u+rwx $HOME

USER ${USER}

CMD [ "/bin/bash" ]