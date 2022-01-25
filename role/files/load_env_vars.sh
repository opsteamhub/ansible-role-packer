#!/bin/sh

/usr/bin/env | grep 'PACKER_VAR_' | sed 's/=/: /g' | sed 's/PACKER_VAR_//g' > ../ansible/vars/general.vars
