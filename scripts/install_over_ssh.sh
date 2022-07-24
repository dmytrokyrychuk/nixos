#!/usr/bin/env bash

read -e -p "Enter a config you want to deploy: " flake

server="nixos@nixos.home.kyrych.uk"
download_command="curl https://github.com/dmytrokyrychuk/nixos/archive/master.tar.gz | tar xz"
install_command="cd ~/nixos && ./scripts/install_local.sh $flake"
rsa_key="~/.ssh/id_ed25519"

ssh-copy-id $server
ssh -i $rsa_key -t $server $download_command
ssh -i $rsa_key -t $server $install_command
