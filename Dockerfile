FROM richtr/supervisor

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get install --no-install-recommends -y init-system-helpers \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && echo exit 0 > /usr/sbin/policy-rc.d

ENV JOBBER_URL https://github.com/dshearer/jobber/releases/download/v1.1/jobber_1.1-1_amd64.deb

ADD $JOBBER_URL /tmp/jobber_pkg.deb

RUN dpkg -i /tmp/jobber_pkg.deb \
    && rm -f /tmp/jobber_pkg.deb

ADD jobber.conf /etc/supervisor/conf.d/jobber.conf
