FROM hypriot/rpi-node:latest

# ENV NODE_ENV production - Temporary fix until "https://github.com/MichMich/MagicMirror/pull/1250" is merged into master.

WORKDIR /opt/magic_mirror

<<<<<<< HEAD
RUN git clone master https://github.com/MichMich/MagicMirror.git .
=======
RUN git clone https://github.com/MichMich/MagicMirror.git .
>>>>>>> b80c671850b2660f035092eb2fa8fb531008666d

RUN cp -R modules /opt/default_modules
RUN cp -R config /opt/default_config
RUN npm install --unsafe-perm --silent

COPY docker-entrypoint.sh /opt
RUN apt-get update \
  && apt-get -qy install dos2unix \
  && dos2unix /opt/docker-entrypoint.sh \
  && chmod +x /opt/docker-entrypoint.sh

EXPOSE 80
CMD ["node serveronly"]
ENTRYPOINT ["/opt/docker-entrypoint.sh"]
