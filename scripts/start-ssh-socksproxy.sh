#!/bin/bash
# Script is intended to be called via docker cmd. Values are set by Environment parameters

mkdir -p ~/.ssh

ssh-keyscan $SSH_HOST >> ~/.ssh/known_hosts


ssh -i $ID_FILE -N -o GatewayPorts=true -D $LOCAL_PORT $SSH_USER@$SSH_HOST