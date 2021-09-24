#!/bin/bash
DATE=$(date '+%Y%m%d%H%M%S')
docker build -t peez/playground:latest .
docker tag peez/playground:latest peez/playground:$DATE

