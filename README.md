# 42 Valgrind
## This will install valgrind in your goinfre folder, say goodbye to docker just for valgrind 🥳 At the time of creating this script, the latest GDB and GMP were used.
### NOTE: Valgrind will segfault if used on any graphical project (fractol, so_long, cub3d, etc...)!!!!! This is a problem with the version of valgrind that was not fixed by the author. It will also show suppressed leaks by default, this is normal since there are a bunch of leaks outside your program on macOS. If its suppressed you shouldnt worry about them, unless of course you have your own supressed leakes.

This will be helpful to those that have no access to docker anymore. Through this installation you will also have access to GDB for thos of you that like GDB more than LLDB. Happy leak hunting y'all.


## Requirements (installed using the script)

- Homebrew
- Automake
- GMP
- GDB



## Installation - Script 

To install valgrind using the script, type the following in your terminal

```bash
    bash install.sh
```
    

## Installation - Manually 

First we need to create a directory to put everything in. it doesnt have to be called "tools" but kae sure to use the same name everywhere if you change it.

```bash
    mkdir /goinfre/$USER/tools
```

Then we need to install homebrew (if you already have it, you are good to go to the next step)

```bash
    curl -fsSL https://rawgit.com/kube/42homebrew/master/install.sh | zsh
```
I recommend moving the .brew directory from your home to the goinfre to save space on you session.
```bash
    mv ~/.brew /goinfre/$USER/.brew
    ln -s /goinfre/$USER/.brew ~/.brew
```

Then we need to install automake to be able to build and install valgrind
```bash
    brew install automake
```

Next up we will instal GMP. GMP is a free library for arbitrary precision arithmetic, operating on signed integers, rational numbers, and floating-point numbers. This is used by GDB and Valgrind. Yes you also have access to GDB through this.

Make sure you use the same directory for the prefix if you changed it.
```bash
    cd "gmp-6.2.1"
    ./configure --prefix="/goinfre/$USER/tools"
    make && make insall
```
Then we install GDB. Again, change the prefix if you changed the directory from the first step.
```bash
    cd ../"gdb-12.1"
    ./configure --prefix="/goinfre/$USER/tools"
    make && make install
 ```

 Almost there, its time to install valgrind. Same thing for the prefix.
 ```bash
    cd ../valgrind
    ./autogen.sh
    ./configure --prefix="/goinfre/$USER/tools" --enable-only64bit
    make && make install
 ```

 Finally, we need to add everything to the path. Same thing for the path, just add "/bin" at the end of it.

 ```bash
    echo "export PATH=$PATH:/goinfre/$USER/tools/bin" >> ~/.zshrc
    source ~/.zshrc
 ```
