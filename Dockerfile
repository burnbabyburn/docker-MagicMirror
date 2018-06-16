FROM hypriot/rpi-node:latest

# ENV NODE_ENV production - Temporary fix until "https://github.com/MichMich/MagicMirror/pull/1250" is merged into master.

WORKDIR /opt/magic_mirror

RUN git clone https://github.com/MichMich/MagicMirror.git .
RUN git clone https://github.com/raywo/MMM-PublicTransportHafas.git ./config/MMM-PublicTransportHafas
RUN git clone https://github.com/fewieden/MMM-Fuel.git ./config/MMM-Fuel
RUN git clone https://github.com/edward-shen/MMM-pages.git ./config/MMM-pages
RUN git clone https://github.com/edward-shen/MMM-page-indicator.git ./config/MMM-page-indicator
RUN git clone https://github.com/paviro/MMM-FRITZ-Box-Callmonitor.git ./config/MMM-FRITZ-Box-Callmonitor

RUN cp -R config /opt/default_config
RUN npm install --unsafe-perm --silent

COPY docker-entrypoint.sh /opt
RUN apt-get update \
  && apt-get -qy install dos2unix python-dev libxml2-dev libxslt1-dev zlib1g-dev python-pip \
  && dos2unix /opt/docker-entrypoint.sh \
  && chmod +x /opt/docker-entrypoint.sh \
  && pip install fritzconnection

EXPOSE 80
CMD ["node serveronly"]
ENTRYPOINT ["/opt/docker-entrypoint.sh"]
