#!/bin/bash
set -ex

rm /app/tmp/pids/server.pid || true
rake db:migrate
bundle exec rails s thin -p 3000 -b '0.0.0.0'
