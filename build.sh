#!/usr/bin/env bash

set -e

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

phpVersions=(
    7.4
    8.0
    8.1
    8.2
)

for phpVersion in ${phpVersions[@]}; do
    docker build --no-cache \
      --build-arg PHP_VERSION="${phpVersion}" \
      -t "mychidarko/leaf-fly-fpm:${phpVersion}" \
      -f "${SCRIPT_DIR}/src/Dockerfile" \
      "${SCRIPT_DIR}/src"
done

if [[ $# -gt 0 ]] && [[ $1 == "push" ]]; then
    for phpVersion in ${phpVersions[@]}; do
        docker push "mychidarko/leaf-fly-fpm:${phpVersion}"
    done
fi
