#!/bin/bash

. scripts/common.sh

plugrepo=https://github.com/tmux-plugins/tpm
plugdir=$HOME/.tmux/plugins/tpm
your_conf=$HOME/.tmux.conf
this_conf=${dotdir}.tmux.conf
tmp_conf=${dotdir}.tmux.conf.tmp
tmp_install_script=$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh

begin "tmux"

if [[ ! -e $your_conf ]] || (echo "You already have a .tmux.conf in your home directory." && confirm "Replace it?") ; then
	echo "Copy $this_conf --> $your_conf"
	cp $this_conf $your_conf
else
	if ! confirm "Do you still want to install tmux plugins?"; then
		exit 0
	fi
fi

# Install TPM?
echo ""
if [[ -d $plugdir ]]; then
	echo "Tmux Plugin Manager already installed."
else
	echo "Installing Tmux Plugin Manager..."
	echo "git clone $plugrepo $plugdir"
	git clone $plugrepo $plugdir
	echo "done."
fi

# TPM plugin install?
echo ""
if confirm "Install TPM plugins now?"; then
	echo "Installing vundle plugins..."
	if ! tmux ls > /dev/null 2> /dev/null ; then
		# start a server but don't attach to it
		tmux start-server
		# create a new session but don't attach to it either
		tmux new-session -d
		sleep 1
		# install the plugins
		$tmp_install_script
		# killing the server is not required, I guess
		tmux kill-server
	else
		echo "You already have tmux running. Please kill the server or install the plugins by yourself by using Prefix + I"
		exit 0
	fi
	echo "done."
fi

end "tmux"
