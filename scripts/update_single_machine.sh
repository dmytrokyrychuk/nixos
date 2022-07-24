#!/usr/bin/env bash

rsa_key="~/.nixos/secrets/ssh_keys/ansible/ansible.key"
export NIX_SSHOPTS="-t -i $rsa_key"

host=$1
fqdn="$host.home.kyrych.uk"
nixos-rebuild switch --use-remote-sudo --build-host localhost --target-host $fqdn --flake ".#$host"
