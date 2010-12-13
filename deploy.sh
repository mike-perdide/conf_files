SCRIPTS_DIR=$PWD

rm ~/.zshrc
ln -s $SCRIPTS_DIR/zshrc ~/.zshrc

rm -r ~/.vim
ln -s $SCRIPTS_DIR/vim ~/.vim

rm ~/.vimrc
ln -s $SCRIPTS_DIR/vimrc ~/.vimrc

if [ ! -L ~/.gitconfig ]
then
    rm ~/.gitconfig
    ln -s $SCRIPTS_DIR/gitconfig_home ~/.gitconfig
fi

rm ~/.lynxrc
ln -s $SCRIPTS_DIR/lynxrc ~/.lynxrc

rm -r ~/.newsbeuter
ln -s $SCRIPTS_DIR/newsbeuter ~/.newsbeuter

rm -r ~/.screenrc
ln -s $SCRIPTS_DIR/screenrc ~/.screenrc

rm ~/.xmodmap
ln -s $SCRIPTS_DIR/xmodmap ~/.xmodmap

rm -r ~/.irssi
ln -s $SCRIPTS_DIR/irssi ~/.irssi
