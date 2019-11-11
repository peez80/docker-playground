#!/bin/bash
# Script is intended to be called via docker cmd. Values are set by Environment parameters
# Running container must have a valid .ssh directory mounted to /app/ssh
set -e


echo "mkdir"
mkdir -p ~/.ssh
echo "cp"
cp -r /app/ssh/* ~/.ssh

echo "ssh-dir:"
ls -lah ~/.ssh

echo "chmod"
chmod -R 600 ~/.ssh

if [ -z "$SSH_PORT" ]; then
  SSH_PORT=22
fi

echo "ssh-keyscan"
ssh-keyscan $SSH_HOST >> ~/.ssh/known_hosts



ssh -p $SSH_PORT -nNT -o GatewayPorts=true -L $LOCAL_PORT:$REMOTE_HOST:$REMOTE_PORT $SSH_USER@$SSH_HOST
