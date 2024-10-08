#!/bin/bash

watt_source_init() {
    read -p "This will clean WATT and its submodules (node_modules, untracked files etc). Are you sure (y/n)?" CONT
    if [ "$CONT" = "y" ]; then
      echo "Cleaning ..."
      git clean -xfdf

      echo "Init ..."
      # Ensure all submodules sources here. Docker image does not
      # have access to repositories.
      ./update_submodules
    fi
}

docker_compose_build() {
    echo "Building ..."
    docker-compose down
    docker-compose build --no-cache
    if [ $? -ne 0 ]; then
        echo "Could not build images"
        exit 1
    fi
}
