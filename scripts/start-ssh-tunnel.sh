#!/bin/bash
# Script is intended to be called via docker cmd. Values are set by Environment parameters

mkdir -p ~/.ssh

ssh-keyscan $SSH_HOST >> ~/.ssh/known_hosts


ssh -i $ID_FILE -nNT -o GatewayPorts=true -L $LOCAL_PORT:$REMOTE_HOST:$REMOTE_PORT $SSH_USER@$SSH_HOST