#!/usr/bin/env bash

readonly CURRENT=$(date +%Y%m%d%H%M%S)
readonly YuukiVIMPATH=$(pwd)
readonly VIMRC="${HOME}/.vimrc"
readonly VIM="${HOME}/.vim"

# 0x00, backup original VIM settings
if [ -f ${VIMRC} ]; then
    mv ${VIMRC} ${VIMRC}.bak-${CURRENT}
fi
if [ -d ${VIM} ]; then
    mv ${VIM} ${VIM}.bak-${CURRENT}
fi

# 0x01, Enable YuukiVIM
mkdir ${VIM}
touch ${VIMRC}
echo "source ${YuukiVIMPATH}/yuuki.vim" >> ${VIMRC}

# 0x02, down and install junegunn/vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

