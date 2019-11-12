#!/bin/bash
# Script is intended to be called via docker cmd. Values are set by Environment parameters
# Running container must have a valid .ssh directory mounted to /app/ssh
set -e


echo "Preparing ~/.ssh from mounted ssh dir /app/ssh"
mkdir -p ~/.ssh
cp -r /app/ssh/* ~/.ssh
chmod -R 600 ~/.ssh

if [ -z "$SSH_PORT" ]; then
  SSH_PORT=22
fi

echo "ssh-keyscan"
ssh-keyscan $SSH_HOST >> ~/.ssh/known_hosts


echo "Create Tunnel at $LOCAL_PORT:$SSH_HOST-$SSH_PORT:$REMOTE_HOST:$REMOTE_PORT"
ssh -p $SSH_PORT -nNT -o GatewayPorts=true -L $LOCAL_PORT:$REMOTE_HOST:$REMOTE_PORT $SSH_USER@$SSH_HOST
