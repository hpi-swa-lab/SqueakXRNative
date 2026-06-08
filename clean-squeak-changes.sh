#/bin/bash

set -e

git restore -WS -- "$(git rev-parse --show-toplevel)/squeak"
