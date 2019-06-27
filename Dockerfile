FROM jenkins/jenkins:lts
LABEL maintainer="info@sebastianboegl.de"

# Labels.
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="theboegl/jenkins-javafx-xvfb"
LABEL org.label-schema.description="Official jenkins LTS version with JavaFX and xvfb"
LABEL org.label-schema.vcs-url="https://github.com/TheBoegl/jenkins-javafx-xvfb"


# Switching from jenkins to root user...
USER root

# Installing openjfx to build javafx programs...
RUN mkdir /var/lib/apt/lists/partial \
        && apt-get update && apt-get install -y --no-install-recommends \
           xvfb \
           openjfx=8u161-b12-1ubuntu2 \
           libopenjfx-java=8u161-b12-1ubuntu2 \
           libopenjfx-jni=8u161-b12-1ubuntu2 \
        && apt-mark hold \
           openjfx \
           libopenjfx-java \
           libopenjfx-jni \
        && rm -rf /var/lib/apt/lists/*

# Switching back from root to jenkins user for any further RUN/CMD/ENTRYPOINT...
USER jenkins
