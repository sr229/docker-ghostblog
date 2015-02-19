#
# Ghost blog.mornati.net
#

# Pull base image.
FROM dockerfile/nodejs

# Install Ghost
RUN \
  cd /tmp && \
  wget https://ghost.org/zip/ghost-latest.zip && \
  unzip ghost-latest.zip -d /ghost && \
  rm -f ghost-latest.zip

COPY run-ghost.sh /run-ghost.sh
RUN chmod 755 /run-ghost.sh
COPY config.js /ghost/config.js

RUN useradd ghost --home /ghost
RUN chown -R ghost:ghost /ghost

USER ghost
ENV HOME /ghost
RUN cd /ghost && \
  npm install --production 


# Define working directory.
WORKDIR /ghost

# Set environment variables.
ENV NODE_ENV production

# Expose ports.
EXPOSE 2368

# Define mountable directories.
VOLUME ["/ghost/content", "/ghost-override"]

# Define default command.
CMD ["/run-ghost.sh"]
