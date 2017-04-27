#!/bin/sh
set -e

if [ ! -z "$ES_HOST" ]; then
  sed -i 's|hosts = \[| hosts = [\\n {\\n    host = \"${ES_HOST}:${ES_PORT]\"\\n    name = \"${ES_NAME}\"\\n  ]|' ./conf/application.conf
fi

gosu cerebro ./bin/cerebro
