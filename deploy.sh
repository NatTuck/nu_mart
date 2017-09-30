#!/bin/bash

export PORT=8000
DIR=$1

if [ ! -d "$DIR" ]; then
  printf "Usage: ./deploy.sh <path>\n"
  exit
fi

echo "Deploy to [$DIR]"

mix deps.get
(cd assets && npm install)
(cd assets && ./node_modules/brunch/bin/brunch b -p)
mix phx.digest
mix release --env=prod

$DIR/bin/nu_mart stop || true

mix ecto.migrate

SRC=`pwd`
(cd $DIR && tar xzvf $SRC/_build/prod/rel/nu_mart/releases/0.0.1/nu_mart.tar.gz)

$DIR/bin/nu_mart start
