set -euo pipefail

WORKINGDIR=$PWD
# install zsh
cd
echo 'Creating GitHub repo and cloning repos'
mkdir -p Software
mkdir -p $HOME/.local
INSTALLATION_PATH="$HOME/.local"

cd $WORKINGDIR/Software
wget https://hisham.hm/htop/releases/2.2.0/htop-2.2.0.tar.gz
wget https://github.com/tmux/tmux/releases/download/2.4/tmux-2.4.tar.gz
wget https://github.com/downloads/libevent/libevent/libevent-2.0.19-stable.tar.gz
wget ftp://ftp.invisible-island.net/ncurses/ncurses.tar.gz
wget -O zsh.tar.xz https://sourceforge.net/projects/zsh/files/latest/download

# htop
echo 'Installing htop'
tar xvfvz htop-2.2.0.tar.gz
rm htop-2.2.0.tar.gz
cd htop-2.2.0
./configure --prefix=$PWD && make && make install
cd ..

############
# libevent #
############
tar xvzf libevent-2.0.19-stable.tar.gz
cd libevent-2.0.19-stable
./configure --prefix=$INSTALLATION_PATH --disable-shared
make
make install
cd ..

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

# Installing tmux
tar xvzf tmux-2.4.tar.gz
cd tmux-2.4
./configure CFLAGS="-I$INSTALLATION_PATH/include -I$INSTALLATION_PATH/include/ncurses" LDFLAGS="-L$INSTALLATION_PATH/lib -L$INSTALLATION_PATH/include/ncurses -L$INSTALLATION_PATH/include"
CPPFLAGS="-I$INSTALLATION_PATH/include -I$INSTALLATION_PATH/include/ncurses" LDFLAGS="-static -L$INSTALLATION_PATH/include -L$INSTALLATION_PATH/include/ncurses -L$INSTALLATION_PATH/lib" make
cp tmux $INSTALLATION_PATH/bin
cd ..

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
