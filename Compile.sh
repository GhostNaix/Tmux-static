#!/bin/bash

if [ ! -f ".Env_prepped" ]; then
	echo "Error: Environment not prepared for tmux static compile..."
	exit 1
fi


get_latest_release() {
    curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

echo "Getting latest version of Tmux"
export Tmux_Version=$(get_latest_release tmux/tmux)
echo "Downloading SRC"
wget "https://github.com/tmux/tmux/releases/download/$Tmux_Version/tmux-$Tmux_Version.tar.gz" -O "tmux.tar.gz"
echo "Extracting SRC"
tar -zxvf "tmux.tar.gz"
cd tmux-*/
echo "Compiling..."
./configure --enable-static --enable-utempter --enable-utf8proc --enable-sixel
make -j$((`nproc`+1))

echo "Stripping binaries"
strip -s tmux
# Finish up
## Create File that marks the environment has been marked
cd ..
echo $Tmux_Version | tee tmux_version.data
touch .tmux_compiled
echo "Done"
exit 0