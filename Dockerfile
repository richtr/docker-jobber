FROM alpine:3.5

# Build parameters
ARG JOBBER_VERSION=v1.1

# Install Jobber from source
RUN export JOBBER_HOME=/tmp/jobber && \
    export JOBBER_LIB=$JOBBER_HOME/lib && \
    export GOPATH=$JOBBER_LIB && \
    export CONTAINER_UID=1000 && \
    export CONTAINER_GID=1000 && \
    export CONTAINER_USER=jobber_client && \
    export CONTAINER_GROUP=jobber_client && \
    # Install tools
    apk add --update libc-dev go git curl wget make && \
    mkdir -p $JOBBER_HOME && \
    mkdir -p $JOBBER_LIB && \
    # Install Jobber
    addgroup -g $CONTAINER_GID jobber_client && \
    adduser -u $CONTAINER_UID -G jobber_client -s /bin/bash -S jobber_client && \
    cd $JOBBER_LIB && \
    go get github.com/dshearer/jobber;true && \
    if  [ "${JOBBER_VERSION}" != "latest" ]; \
      then \
        # wget --directory-prefix=/tmp https://github.com/dshearer/jobber/releases/download/v1.1/jobber-${JOBBER_VERSION}-r0.x86_64.apk && \
        # apk add --allow-untrusted /tmp/jobber-${JOBBER_VERSION}-r0.x86_64.apk ; \
        cd src/github.com/dshearer/jobber && \
        git checkout tags/${JOBBER_VERSION} && \
        cd $JOBBER_LIB ; \
    fi && \
    make -C src/github.com/dshearer/jobber install DESTDIR=$JOBBER_HOME && \
    cp $JOBBER_LIB/bin/jobber /usr/bin/ && \
    cp -p $JOBBER_LIB/bin/jobberd /usr/sbin/jobberd

# Install supervisord (+ bash for docker exec access)
RUN apk --no-cache add supervisor bash

# Cleanup
RUN apk del libc-dev go git curl wget make && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/* && \
    rm -rf /var/log/*

# Forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/jobber.out.log
RUN ln -sf /dev/stderr /var/log/jobber.err.log

COPY supervisord.conf /etc/supervisord.conf

# No entrypoint set as this image is meant to be extended. You can run in your own Dockerfile:
#ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
