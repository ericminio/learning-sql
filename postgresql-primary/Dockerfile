FROM postgres:17.4

RUN echo "PS1='\n\[\e[32m\]\u \[\e[33m\]in \w\[\e[0m\] \n> '" >> ~/.bashrc

COPY init/ /docker-entrypoint-initdb.d/

WORKDIR /usr/local/src
