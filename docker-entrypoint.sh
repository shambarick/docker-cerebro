#!/bin/sh
set -e

CEREBRO_OPTS=""

if [ ! -z "$ES_HOST" ]; then
  CEREBRO_OPTS="${CEREBRO_OPTS} -Dhttp.address=${ES_HOST}"
fi

if [ ! -z "$ES_PORT" ]; then
  CEREBRO_OPTS="${CEREBRO_OPTS} -Dhttp.port=${ES_PORT}"
fi

gosu cerebro ./bin/cerebro $CEREBRO_OPTS
