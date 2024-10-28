#!/bin/bash

k3d cluster delete -a
docker system prune -af --volumes
