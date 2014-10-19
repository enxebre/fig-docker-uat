#!/bin/sh

set -e

host=selenium
port=$(env | grep _ENV_SELENIUM_PORT | cut -d = -f 2)

echo -n "waiting for TCP connection to $host:$port..."

while ! nc -w 1 $host $port 2>/dev/null
do
  echo -n .
  sleep 1
done

pushd behat >/dev/null
bin/behat
popd >/dev/null
