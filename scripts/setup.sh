#!/bin/sh -xe

export TFNOTIFY=https://github.com/mercari/tfnotify/releases/download/v0.3.0/tfnotify_v0.3.0_linux_amd64.tar.gz
echo "installing scripts"

cd tmp
wget $TFNOTIFY -O /tmp/t.tgz
tar xvfz /tmp/t.tgz -C /tmp/
cd -
pwd
ls
mv /tmp/tfnotify*/tfnotify scripts/
ls -slha scripts
