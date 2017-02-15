#! /usr/bin/env bash

set -e -x -u

pushd mini_portile

  bundle install
  bundle exec rake test

popd
