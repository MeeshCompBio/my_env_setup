set -euo pipefail

WORKINGDIR=$PWD
# install zsh
cd
echo 'Creating GitHub repo and cloning repos'
mkdir -p GitHub
mkdir -p Software
mkdir -p $HOME/.local
INSTALLATION_PATH="$HOME/.local"
# Enter and clone necessary repos
# cd $WORKINGDIR/GitHub
# git clone https://github.com/tmux/tmux.git
#git clone https://github.com/zsh-users/zsh.git

cd $WORKINGDIR/Software
wget https://hisham.hm/htop/releases/2.2.0/htop-2.2.0.tar.gz
wget https://github.com/tmux/tmux/releases/download/2.4/tmux-2.4.tar.gz
wget https://github.com/downloads/libevent/libevent/libevent-2.0.19-stable.tar.gz
# wget ftp://ftp.gnu.org/gnu/ncurses/ncurses-5.9.tar.gz
wget ftp://ftp.invisible-island.net/ncurses/ncurses.tar.gz
# wget http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz
# wget http://ftp.gnu.org/gnu/automake/automake-1.11.6.tar.gz
# wget http://mirror.jre655.com/GNU/libtool/libtool-2.4.6.tar.gz
# wget https://github.com/downloads/libevent/libevent/libevent-2.0.19-stable.tar.gz
wget -O zsh.tar.xz https://sourceforge.net/projects/zsh/files/latest/download
# wget https://pkg-config.freedesktop.org/releases/pkg-config-0.29.2.tar.gz

# # autoconf
# tar xf autoconf*
# cd autoconf-2.69
# ./configure --prefix $INSTALLATION_PATH && make && make install
# cd ..

# #automake
# tar xf automake*
# cd automake-1.11.6
# ./configure --prefix $INSTALLATION_PATH && make && make install
# make install
# cd ..

# #libtool
# tar xf libtool*
# cd libtool-2.4.6
# ./configure --prefix $INSTALLATION_PATH && make && make install
# make install 
# cd ..

# #libevent
# tar xvzf libevent-2.0.19-stable.tar.gz
# cd libevent-2.0.19-stable
# ./configure --prefix=$INSTALLATION_PATH && make && make install
# cd ..

# htop
echo 'Installing htop'
tar xvfvz htop-2.2.0.tar.gz
rm htop-2.2.0.tar.gz
cd htop-2.2.0
./configure --prefix=$PWD && make && make install
cd ..

# tar xvfz pkg-config-0.29.2.tar.gz
# cd pkg-config-0.29.2
# ./configure --prefix=$INSTALLATION_PATH --with-internal-glib && make && make install
# cd ..

############
# libevent #
############
tar xvzf libevent-2.0.19-stable.tar.gz
cd libevent-2.0.19-stable
./configure --prefix=$INSTALLATION_PATH --disable-shared
make
make install
cd ..

############
# ncurses  #
############
# tar xvzf ncurses-5.9.tar.gz
# cd ncurses-5.9
# ./configure --prefix=$INSTALLATION_PATH
# make
# make install
# cd ..


# need ncurses
echo "Installing ncurses"
tar xvzf ncurses.tar.gz
cd ncurses-6.2
export CXXFLAGS=" -fPIC"
export CFLAGS=" -fPIC"
./configure --prefix=$HOME/.local --enable-shared && make && make install
INSTALLATION_PATH="$HOME/.local"
export PATH=$INSTALLATION_PATH/bin/:$PATH
export LD_LIBRARY_PATH=$INSTALLATION_PATH/lib
export CFLAGS=-I$INSTALLATION_PATH/include
export CPPFLAGS="-I$INSTALLATION_PATH/include" LDFLAGS="-L$INSTALLATION_PATH/lib"
cd ..


tar xvzf tmux-2.4.tar.gz
cd tmux-2.4
./configure CFLAGS="-I$INSTALLATION_PATH/include -I$INSTALLATION_PATH/include/ncurses" LDFLAGS="-L$INSTALLATION_PATH/lib -L$INSTALLATION_PATH/include/ncurses -L$INSTALLATION_PATH/include"
CPPFLAGS="-I$INSTALLATION_PATH/include -I$INSTALLATION_PATH/include/ncurses" LDFLAGS="-static -L$INSTALLATION_PATH/include -L$INSTALLATION_PATH/include/ncurses -L$INSTALLATION_PATH/lib" make
cp tmux $INSTALLATION_PATH/bin
cd ..

# # Go to github installs for tmux
# cd $WORKINGDIR/GitHub/tmux
# echo 'Installing tmux'
# ./autogen.sh
# ./configure --prefix=$INSTALLATION_PATH && make && make install
# cd ..

#############################
# ZSH, OH MY ZSH AND PLUGINS
#############################
echo 'installing zsh and ohmyzsh'
cd $WORKINGDIR/Software
mkdir zsh && unxz zsh.tar.xz && tar -xvf zsh.tar -C zsh --strip-components 1
# rm zsh.tar
cd zsh
./configure --prefix=$INSTALLATION_PATH && make && make install

# copy zshrc
cp StartupFiles/zshrc ~/.zshrc
cd

# install oh my zsh
Y | sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" || true

# Add plugins here
# Add powelevel 10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/themes/powerlevel10k
sed -i "/ZSH_THEME=\"r/c\ZSH_THEME=\"powerlevel10k/powerlevel10k\"" ~/.zshrc ~/.zshrc
# add syntax-highlighitng
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
# add auto suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# modifications to the .zshrc to add plugins and such
sed -i 's/.*plugins=(g.*/plugins=(git colored-man-pages zsh-syntax-highlighting zsh-autosuggestions)/' ~/.zshrc

# add aliases
cd $WORKINGDIR
cat bashrc_aliases.sh >> ~/.zshrc

# vim setup
echo 'Setting up vim'
curl 'https://vim-bootstrap.com/generate.vim' --data 'langs=python&editor=vim' > ~/.vimrc

# adding dracula theme
sed -i "/required by fugitive/i\Plug 'dracula/vim', { 'as': 'dracula' }" ~/.vimrc
sed "/silent\! colorscheme/c\silent! colorscheme dracula" ~/.vimrc
# vim -c PlugInstall command line to install vim plugins, but then again user need to know how to exit it....

# make zsh the default shell
echo "making zsh the default shell on startup, modifying .bashrc"
cd
cat bashrc_mod.sh >> ~/.bashrc
souce ~/.bashrc

# adding a tmux conf file
cat tmux_config_options.sh > ~/.tmux.conf

# make local vimrc for my personal modifications
# touch ~/.vimrc.local
# touch ~/.vimrc.local.bundles
# install all of the plugins
# vim +PluginInstall +qall


# # bashrc
# echo 'modifying bashrc'
# cd WORKINGDIR
# cat bashrc_aliases >> .bashrc