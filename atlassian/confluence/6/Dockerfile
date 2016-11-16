FROM bitweb/java:8
MAINTAINER BitWeb

# Setup useful environment variables
ENV HOME_DIR          /var/atlassian/confluence
ENV INSTALL_DIR       /opt/atlassian/confluence
ENV VERSION           6.0.1

# MySQL Connector
ENV CONNECTOR_VERSION      5.1.40
ENV CONNECTOR_DOWNLOAD_URL https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${CONNECTOR_VERSION}.tar.gz

#################################################
####     No need to edit below this line     ####
#################################################

# Install Confluence dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends xmlstarlet curl htop nano \
    && apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}

# Install Atlassian Confluence and helper tools and setup initial home directory structure.
RUN set -x \
    && mkdir -p                "${HOME_DIR}" \
    && chmod -R 700            "${HOME_DIR}" \
    && mkdir -p                "${INSTALL_DIR}/conf" \
    && curl -Ls                "http://www.atlassian.com/software/confluence/downloads/binary/atlassian-confluence-${VERSION}.tar.gz" | tar -xz --directory "${INSTALL_DIR}" --strip-components=1 --no-same-owner \
    && curl -Ls                ${CONNECTOR_DOWNLOAD_URL} | tar -xz --directory ${INSTALL_DIR}/confluence/WEB-INF/lib --strip-components=1 --no-same-owner "mysql-connector-java-$CONNECTOR_VERSION/mysql-connector-java-$CONNECTOR_VERSION-bin.jar" \
    && chmod -R 700            "${INSTALL_DIR}/conf" \
    && chmod -R 700            "${INSTALL_DIR}/temp" \
    && chmod -R 700            "${INSTALL_DIR}/logs" \
    && chmod -R 700            "${INSTALL_DIR}/work" \
    && echo -e                 "\nconfluence.home=$HOME_DIR" >> "${INSTALL_DIR}/confluence/WEB-INF/classes/confluence-init.properties" \
    && xmlstarlet              ed --inplace \
        --delete               "Server/@debug" \
        --delete               "Server/Service/Connector/@debug" \
        --delete               "Server/Service/Connector/@useURIValidationHack" \
        --delete               "Server/Service/Connector/@minProcessors" \
        --delete               "Server/Service/Connector/@maxProcessors" \
        --delete               "Server/Service/Engine/@debug" \
        --delete               "Server/Service/Engine/Host/@debug" \
        --delete               "Server/Service/Engine/Host/Context/@debug" \
                               "${INSTALL_DIR}/conf/server.xml" \
    && touch -d "@0"           "${INSTALL_DIR}/conf/server.xml"

# Set the default working directory as the installation directory.
WORKDIR $INSTALL_DIR

# Expose default HTTP connector port.
EXPOSE 8090

# Startup
CMD ["./bin/catalina.sh", "run"]
