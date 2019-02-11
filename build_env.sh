# Clean env
sudo yum -y remove vim
rm -rf ~/.vim*

# build with python support
sudo yum -y install epel-release
sudo yum -y update

# Install packages
sudo yum -y install python34 python34-devel gcc ncurses ncurses-devel python python-devel ruby ruby-devel lua lua-devel luajit luajit-devel ctags tcl-devel perl perl-devel perl-ExtUtils-ParseXS perl-ExtUtils-XSpp perl-ExtUtils-CBuilder perl-ExtUtils-Embed mono-devel golang golang-src npm cargo cmake

# Build latest VIM from src
sudo git clone https://github.com/vim/vim.git /usr/src/vim
cd /usr/src/vim
sudo ./configure --with-features=huge \
    --enable-multibyte \
    --enable-rubyinterp=yes \
    --enable-pythoninterp=yes \
    --with-python-config-dir=/usr/lib64/python2.7/config \
    --enable-python3interp=yes \
    --with-python3-config-dir=/usr/lib64/python3.4/config-3.4m \
    --enable-perlinterp=yes \
    --enable-luainterp=yes \
    --enable-gui=gtk2 \
    --enable-cscope \
    --prefix=/usr/local \
    --enable-fail-if-missing
sudo make install
sudo ln -s /usr/local/bin/vim /usr/bin/vim

git clone https://github.com/VundleVim/Vundle.vim.git ~/.env/.vim/bundle/Vundle.vim

rm -rf ~/.vim/
rm -rf ~/.vimrc
rm -rf ~/.viminfo
ln -s ~/.env/.vim/ ~/.vim
ln -s ~/.env/.vimrc ~/.vimrc
ln -s ~/.env/.viminfo ~/.viminfo
rm -rf ~/.bashrc
rm -rf ~/.bash_logout
rm -rf ~/.bash_profile
ln -s ~/.env/.bashrc ~/.bashrc
ln -s ~/.env/.bash_logout ~/.bash_logout
ln -s ~/.env/.bash_profile ~/.bash_profile

echo 'When VIM launches, execute ":VundleInstall"'

while [[ -z ${anyKey+x} ]]
do
    read -n1 -r -p "Press any key to continue..." anyKey
done

vim

cd ~/.env/.vim/bundle/YouCompleteMe
./install.py --all
