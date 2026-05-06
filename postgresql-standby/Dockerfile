FROM postgres:17.4

RUN echo "PS1='\n\[\e[32m\]\u \[\e[33m\]in \w\[\e[0m\] \n> '" >> ~/.bashrc

COPY entrypoint.sh /usr/local/bin/standby-entrypoint.sh
RUN chmod +x /usr/local/bin/standby-entrypoint.sh

WORKDIR /usr/local/src

ENTRYPOINT ["/usr/local/bin/standby-entrypoint.sh"]
CMD ["postgres"]
