FROM jbaptperez/jenkins-javafx

# Switching from jenkins to root user...
USER root

# Installing openjfx to build javafx programs...
RUN mkdir /var/lib/apt/lists/partial \
        && apt-get update && apt-get install -y --no-install-recommends \
           xvfb \
        && rm -rf /var/lib/apt/lists/*

# Switching back from root to jenkins user for any further RUN/CMD/ENTRYPOINT...
USER jenkins
