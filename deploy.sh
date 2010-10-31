SCRIPTS_DIR=$PWD

rm ~/.zshrc
ln -s $SCRIPTS_DIR/zshrc ~/.zshrc

rm -r ~/.vim
ln -s $SCRIPTS_DIR/vim ~/.vim

rm ~/.vimrc
ln -s $SCRIPTS_DIR/vimrc ~/.vimrc

rm ~/.gitconfig
ln -s $SCRIPTS_DIR/gitconfig_home ~/.gitconfig

rm ~/.lynxrc
ln -s $SCRIPTS_DIR/lynxrc ~/.lynxrc

rm -r ~/.newsbeuter
ln -s $SCRIPTS_DIR/newsbeuter ~/.newsbeuter

rm -r ~/.screenrc
ln -s $SCRIPTS_DIR/screenrc ~/.screenrc
