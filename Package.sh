#!/bin/bash
if [ ! -f ".Env_prepped" ]; then
    echo "Error: Tmux has not been compiled yet halting..."
    exit 1
fi

if [ ! -f "tmux_version.data" ]; then
    echo "Error: No Tmux version data detected. Stopping..."
    exit 1
fi

export Tmux_Version=$(cat tmux_version.data)
cd tmux-*/
echo "Packaging Tmux Static binaries for distribution...."
tar -czvf ../Tmux-Static-$Tmux_Version-x86_64.tar.gz tmux
tar -cJvf ../Tmux-Static-$Tmux_Version-x86_64.tar.xz tmux
zip ../Tmux-Static-$Tmux_Version-x86_64.zip tmux
echo "Done"
exit