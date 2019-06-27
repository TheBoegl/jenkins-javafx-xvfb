FROM jenkins/jenkins:lts
LABEL maintainer="info@sebastianboegl.de"

# Labels.
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="theboegl/jenkins-javafx-xvfb"
LABEL org.label-schema.description="Official jenkins LTS version with JavaFX and xvfb"
LABEL org.label-schema.vcs-url="https://github.com/TheBoegl/jenkins-javafx-xvfb"


# Switching from jenkins to root user...
USER root

ARG OPENJFX_VERSION=8u141*

# Installing openjfx to build javafx programs...
RUN mkdir /var/lib/apt/lists/partial \
        && apt-get update && apt-get install -y --no-install-recommends \
           xvfb \
           openjfx=$OPENJFX_VERSION \
           libopenjfx-java=$OPENJFX_VERSION \
           libopenjfx-jni=$OPENJFX_VERSION \
        && apt-mark hold \
           openjfx \
           libopenjfx-java \
           libopenjfx-jni \
        && rm -rf /var/lib/apt/lists/* \
        && ln -s /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/ext/jfxrt.jar /usr/local/openjdk-8/jre/lib/ext/jfxrt.jar \
        && chmod 0644 /usr/local/openjdk-8/jre/lib/ext/jfxrt.jar \
        && chown root:staff -h /usr/local/openjdk-8/jre/lib/ext/jfxrt.jar

# Switching back from root to jenkins user for any further RUN/CMD/ENTRYPOINT...
USER jenkins
