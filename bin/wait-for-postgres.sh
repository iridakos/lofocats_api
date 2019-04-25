#!/bin/sh
set -e

until pg_isready; do sleep 1; done

exec "$@"
