SCRIPTS_DIR=$PWD

check_installed(){
    is_installed=$(dpkg -l|grep " $1 "|wc -l)
}

deploy(){
    # $1 is the program name (e.g. vim)
    # $2 is the destination of the script (e.g. ~/.vimrc)
    # $3 is the source of the script (e.g. ~/conffiles/vimrc)
    check_installed $1
    if [ $is_installed ] && [ ! -L $2 ]
    then
        echo "$1 is installed, deploying $2"
        rm -r $2
        ln -s $3 $2
    fi
}


deploy zsh ~/.zshrc $SCRIPTS_DIR/zshrc

deploy vim ~/.vim $SCRIPTS_DIR/vim
deploy vim ~/.vimrc $SCRIPTS_DIR/vimrc

deploy git-core ~/.gitconfig $SCRIPTS_DIR/gitconfig_home

deploy lynx ~/.lynxrc $SCRIPTS_DIR/lynxrc

deploy newsbeuter ~/.newsbeuter $SCRIPTS_DIR/newsbeuter

deploy screen ~/.screenrc $SCRIPTS_DIR/screenrc

deploy bash ~/.xmodmap $SCRIPTS_DIR/xmodmap

deploy irssi ~/.irssi $SCRIPTS_DIR/irssi

deploy xserver-xorg-core ~/.Xdefaults $SCRIPTS_DIR/Xdefaults

is_installed_awesome=$(check_installed awesome)
if [ $is_installed ]
then
    mkdir -p .config/awesome
fi
deploy awesome ~/.config/awesome/rc.lua $SCRIPTS_DIR/awesome3/rc.lua
deploy awesome ~/.config/awesome/theme.lua $SCRIPTS_DIR/awesome3/theme.lua

deploy mercurial ~/.hgrc $SCRIPTS_DIR/hgrc
