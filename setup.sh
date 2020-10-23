#!/bin/bash

TERMINAL=$(tty)
HEIGHT=25
WIDTH=70
CHOICE_HEIGHT=10
BACKTITLE="Le Wagon - Data Science"
TITLE="Setup Menu"
MENU="Choose option:"

OPTIONS=(1 "Install git/zsh/curl/vim"
         2 "Install Oh-My-Zsh"
	 3 "Uninstall Oh-My-Zsh"
	 4 "Create new ssh key"
	 5 "Print current ssh key and check github access"
	 6 "Install Dotfiles"
	 7 "Install Python"
	 8 "Install Python Virtual Environment"
	 9 "Install Python Packages")
CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
	        --title "$TITLE" \
	        --menu "$MENU" \
	        $HEIGHT $WIDTH $CHOICE_HEIGHT \
	        "${OPTIONS[@]}" \
	        2>&1 >$TERMINAL)
clear
case $CHOICE in
 	1)
 		sudo apt update
		sudo apt install -y git zsh curl vim jq
		;;														
	2)
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
		;;														
	3)
		sh "/home/`whoami`/.oh-my-zsh/tools/uninstall.sh"	
		;;
	4)
		#echo -e "What is your Github email?\n"
 		#read email
		#echo -e "Confirm your Github email\n"
		#read email2
		#if [ "$email" == "$email2" ]; then
			#mkdir -p ~/.ssh && ssh-keygen -t ed25519 -o -a 100 -f ~/.ssh/id_ed25519 -C $email
			#echo -e "\n"
			#cat ~/.ssh/id_ed25519.pub
			#echo -e "\n"
			#GREEN='\033[0;32m'
			#echo -e "$GREEN Go to https://github.com/settings/ssh to add your new ssh key"
		#else
			#echo "Sorry, emails don't match"
		#fi
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
    sudo apt-add-repository https://cli.github.com/packages
    sudo apt update
    sudo apt install gh
    gh auth login
    login=$(gh api user | jq -r '.login')
    email=$(gh api user | jq -r '.email')
    if [[ "$email" == "null" ]]; then
        echo "You need to untick 'Keep my email address private' at https://github.com/settings/emails"
    else
        mkdir -p ~/.ssh && ssh-keygen -t ed25519 -o -a 100 -f ~/.ssh/id_ed25519 -C $email
        echo -e "\n"
        cat ~/.ssh/id_ed25519.pub
        echo -e "\n"
    fi
	  ;;
	5)
		cat ~/.ssh/id_ed25519.pub
		echo -e "\n"
		ssh -Ty git@github.com
		;;
	6)
		echo -e "What is your Github username?\n"
		read gh_username
		echo -e "Confirm your Github username\n"
		read gh_username2
		if [ "$gh_username" == "$gh_username2" ]; then
			status_code=$(curl -o /dev/null -s -w "%{http_code}\n" https://github.com/$gh_username/dotfiles)
			if [ $status_code -eq 200 ]; then
				export GITHUB_USERNAME=$gh_username
				mkdir -p ~/code/$GITHUB_USERNAME && cd $_ && git clone git@github.com:$GITHUB_USERNAME/dotfiles.git
				current_path=`pwd`
				cd ~/code/$GITHUB_USERNAME/dotfiles/
				zsh install.sh
				zsh git_setup.sh
				cd $current_path
			else
				RED='\033[0;31m'
				echo -e "$RED You need to fork lewagon/dotfiles repository: https://github.com/lewagon/dotfiles/fork"
			fi
		else
				echo "Sorry, usernames don't match"
		fi
		;;
	7)
		git clone https://github.com/pyenv/pyenv.git ~/.pyenv
		sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
			libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev \
			    xz-utils tk-dev libffi-dev liblzma-dev python-openssl
		source ~/.zshrc
		pyenv install 3.8.5
		pyenv global 3.8.5
		python --version
		;;
	8)
    source ~/.zshrc
		git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
		pyenv virtualenv 3.8.5 lewagon
		source ~/.zshrc
		;;
	9)
    source ~/.zshrc
		pip install --upgrade pip
		pip install pytest pylint ipdb pyyaml
		pip install requests bs4
		pip install jupyterlab pandas matplotlib seaborn plotly scikit-learn
		;;
esac
