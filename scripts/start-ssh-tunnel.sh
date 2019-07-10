#!/bin/bash
# Script is intended to be called via docker cmd. Values are set by Environment parameters

mkdir -p ~/.ssh

if [ -z "$SSH_PORT" ]; then
  SSH_PORT=22
fi


if [ -z "$SSH_PROXY_COMMAND" ]; then
  THE_PROXY_COMMAND= 
else
  THE_PROXY_COMMAND="-o ProxyCommand='$PROXY_COMMAND'"
fi


ssh-keyscan $SSH_HOST >> ~/.ssh/known_hosts


ssh -i $ID_FILE -p $SSH_PORT -nNT $THE_PROXY_COMMAND -o GatewayPorts=true -L $LOCAL_PORT:$REMOTE_HOST:$REMOTE_PORT $SSH_USER@$SSH_HOST
