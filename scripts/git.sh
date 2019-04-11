#!/bin/bash

. scripts/common.sh

begin "git"

if confirm "Configure your global git settings?" ; then
	read -p "git.config --global user.name = " name
	read -p "git.config --global user.email = " email
	git config --global user.name "$name"
	git config --global user.email "$email"
fi

# handy abbrevs
echo ""
if confirm "Would you like some handy shortcuts?"; then
	set -x
	git config --global alias.plog "log --pretty=oneline"
	git config --global alias.blog "log --oneline --decorate --graph --all"
	git config --global alias.ignore "!gi() { curl -L -s https://www.gitignore.io/api/$@ ;}; gi"
	git config --global alias.s status
	git config --global alias.co checkout
	git config --global alias.unstage "reset HEAD --"
	set +x
	echo "done."
fi

# Generate an SSH key?
echo ""
if confirm "Would you like to generate an SSH key?" ; then
	email=`git config --global user.email`
	email=`prompt_or_default "Enter the email to be used for keygen" "$email"`
	key=`prompt_or_default "Enter file in which to save the key" "$HOME/.ssh/id_rsa"`
	ssh-keygen -t rsa -b 4096 -C "$email" -f $key
	eval $(ssh-agent -s) > /dev/null
	echo "Adding ssh key to ssh-agent"
	ssh-add "$key"

	echo ""
	echo "Here is your public key to copy to GitHub:"
	cat "$key.pub"
fi
end "git"
