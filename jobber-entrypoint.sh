#!/bin/bash

# Setup supervisord
if [ -d /tmp/config ]; then
  cp /tmp/config/supervisord.conf /etc/supervisord.conf

  mkdir -p /etc/supervisord/conf.d
  cp /tmp/config/conf.d/jobber.conf /etc/supervisord/conf.d/jobber.conf

  rm -rf /tmp/config
fi

# Start supervisord
/usr/bin/supervisord -c /etc/supervisord.conf
