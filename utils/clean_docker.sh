#!/bin/bash
docker volume rm $(docker volume ls -qf dangling=true)
docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
docker rm $(docker ps -qa --no-trunc --filter "status=exited")
