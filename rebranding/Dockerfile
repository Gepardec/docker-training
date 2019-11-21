FROM node:6

RUN apt-get update && \
    apt-get install -y --no-install-recommends tree git bzip2 && \
    curl -sSL https://get.docker.com | sh

WORKDIR /opt/revealjs

RUN ln -s /usr/bin/nodejs /usr/bin/node && \
    git clone https://github.com/hakimel/reveal.js.git /opt/revealjs && \
    git clone https://github.com/denehyg/reveal.js-menu.git /opt/revealjs/plugin/menu && \
    npm cache clean --force && \
    npm install

ENTRYPOINT ["/bin/prompt"]

COPY prompt /bin/prompt
COPY present.py /opt/revealjs/
COPY fonts /opt/revealjs/src/fonts/
COPY css /opt/revealjs/src/css/
COPY templates /opt/revealjs/templates/
COPY images /opt/revealjs/images/
COPY presentations /opt/revealjs/src/presentations/
COPY modules /opt/revealjs/src/modules/
