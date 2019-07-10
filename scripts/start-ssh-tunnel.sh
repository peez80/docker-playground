#!/bin/bash
# Script is intended to be called via docker cmd. Values are set by Environment parameters
# Running container must have a valid .ssh directory mounted to /app/ssh

mkdir -p ~/.ssh
cp -r /app/ssh/* ~/.ssh
chmod -r 600 ~/.ssh

if [ -z "$SSH_PORT" ]; then
  SSH_PORT=22
fi


ssh-keyscan $SSH_HOST >> ~/.ssh/known_hosts

echo "ssh-dir:"
ls -lah ~/.ssh

ssh -p $SSH_PORT -nNT -o GatewayPorts=true -L $LOCAL_PORT:$REMOTE_HOST:$REMOTE_PORT $SSH_USER@$SSH_HOST
