FROM jenkins/jenkins:lts
LABEL maintainer="info@sebastianboegl.de"

# Labels.
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="theboegl/jenkins-javafx-xvfb"
LABEL org.label-schema.description="Official jenkins LTS version with JavaFX and xvfb"
LABEL org.label-schema.vcs-url="https://github.com/TheBoegl/jenkins-javafx-xvfb"


# Switching from jenkins to root user...
USER root

# Installing xvfb to run java programs headlessly...
RUN mkdir /var/lib/apt/lists/partial \
        && apt-get update && apt-get install -y --no-install-recommends \
           xvfb xz-utils \
        && rm -rf /var/lib/apt/lists/*

ARG JFX_URL=https://artifactory.luxoft.com/ojdk8rhel6-generic/java-1.8.0-openjdk-1.8.0.272.b10-0.el6_10.x86_64-nosystemnss-withopenjfx.tar.xz
ARG JFX_CHECKSUM=9f108f3bb41ca2266c313b4ee96cfeab3ddbeb9bd4b25328151ebe878f66511f

# Downloading and extracting openjdk build with openjfx which is no longer available as openjfx 8 package in buster
RUN  curl -LfsSo /tmp/ojdkfx.tar.xz ${JFX_URL} \
        && echo "${JFX_CHECKSUM} */tmp/ojdkfx.tar.xz" | sha256sum -c - \
        && mkdir -p /opt/java/ojdkfx \
        && cd /opt/java/ojdkfx \
        && tar -xf /tmp/ojdkfx.tar.xz --strip-components=1 \
        && rm -rf  /tmp/ojdkfx.tar.xz

ENV JAVA_HOME=/opt/java/ojdkfx \
    PATH="/opt/java/ojdkfx/bin:$PATH"

# Switching back from root to jenkins user for any further RUN/CMD/ENTRYPOINT...
USER jenkins
