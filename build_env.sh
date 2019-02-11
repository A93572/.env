until [[ -d ${userHome} ]]; do
    read -r -p "Enter user's home directory: " userHome
done

# Clean env
yum -y remove vim
rm -rf $usersHome/.vim*

# build with python support
yum -y install epel-release
yum -y update

# Install packages
yum -y install python34 python34-devel gcc ncurses ncurses-devel python python-devel ruby ruby-devel lua lua-devel luajit luajit-devel ctags tcl-devel perl perl-devel perl-ExtUtils-ParseXS perl-ExtUtils-XSpp perl-ExtUtils-CBuilder perl-ExtUtils-Embed mono-devel golang golang-src npm cargo cmake

# Build latest VIM from src
git clone https://github.com/vim/vim.git /usr/src/vim
cd /usr/src/vim
./configure --with-features=huge \
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
make install
ln -s /usr/local/bin/vim /usr/bin/vim

git clone https://github.com/VundleVim/Vundle.vim.git $usersHome/.env/.vim/bundle/Vundle.vim

rm -rf $usersHome/.vim/
rm -rf $usersHome/.vimrc
rm -rf $usersHome/.viminfo
ln -s $usersHome/.env/.vim/ $usersHome/.vim
ln -s $usersHome/.env/.vimrc $usersHome/.vimrc
ln -s $usersHome/.env/.viminfo $usersHome/.viminfo
rm -rf $usersHome/.bashrc
rm -rf $usersHome/.bash_logout
rm -rf $usersHome/.bash_profile
ln -s $usersHome/.env/.bashrc $usersHome/.bashrc
ln -s $usersHome/.env/.bash_logout $usersHome/.bash_logout
ln -s $usersHome/.env/.bash_profile $usersHome/.bash_profile

echo 'When VIM launches execute ":VundleInstall"'

while [[ -z ${anyKey+x} ]]
do
    read -n1 -r -p "Press anykey to continue..." anyKey
done

vim

cd $usersHome/.env/.vim/bundle/YouCompleteMe
./install.py --all
