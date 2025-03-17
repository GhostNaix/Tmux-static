#!/bin/bash
echo "Preparing Environment"
sudo apt install -y libevent-dev ncurses-dev build-essential bison \
pkg-config zip tar libutf8proc* libutf8proc-dev libutempter* libutempter-dev libsixel*
# Finish up
## Create File that marks the environment has been marked
touch .Env_prepped
echo "Done"
exit 0