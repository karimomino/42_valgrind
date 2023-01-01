#!/bin/bash

git pull --recurse-submodules

#Creating directory to install all the tools in
if [! -d "/goinfre/$USER/tools" ] && [! -L "~/.brew"]
then	
	mkdir /goinfre/$USER/tools
fi

#installing brew if not installed already
if [ -d "/goinfre/$USER/.brew" ] || [-L "~/.brew"] 
then
	echo "✅ Homebrew Is Installed Locally Already."
else
  	echo "Installing Homebrew In goinfre Folder...."
	curl -fsSL https://rawgit.com/kube/42homebrew/master/install.sh | zsh
	mv ~/.brew /goinfre/$USER/.brew
	ln -s /goinfre/$USER/.brew ~/.brew
fi

#installing automake to build and install valgrind
echo "Installing automake"
brew install automake

#installing GMP. GMP is a free library for arbitrary precision arithmetic, operating on signed integers, rational numbers, and floating-point numbers. This is used by GDB and Valgrind. Yes you also have access to GDB through this.
cd "gmp-6.2.1"
./configure --prefix="/goinfre/$USER/tools"
make && make insall

#Configure, build, and install GDB from the source-code.
cd ../"gdb-12.1"
./configure --prefix="/goinfre/$USER/tools"
make && make install

#Configure, build, and install valgrind from the source-code.
cd ../valgrind
./autogen.sh
./configure --prefix="/goinfre/$USER/tools" --enable-only64bit
make && make install

#adding new bin location to path
echo "export PATH=$PATH:/goinfre/$USER/tools/bin" >> ~/.zshrc
source ~/.zshrc
