#!/bin/sh
set -e

if [ ! -z "$ES_HOST" ]; then
  confd -onetime -backend env
fi

gosu cerebro ./bin/cerebro
