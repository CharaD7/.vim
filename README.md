# VIM Config
A vim terminal configuration for alx-students

### Steps to install and configure

* Compile vim with Python support.
  - Clone vim from the [official github page](https://github.com/vim/vim.git)
  - Change directory to cloned directory and compile with python support using the below command:
      - ```bash
       sudo ./configure --with-features=huge \
       --enable-multibyte \
       --enable-pythoninterp=yes \
       --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu/ \  # pay attention here check directory correct \
       --enable-python3interp=yes \
       --with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu/ \  # pay attention here check directory correct \
       --enable-gui=gtk2 \
       --enable-cscope \ 
       --prefix=/usr/local/
      
       sudo make VIMRUNTIMEDIR=/usr/local/share/vim/vim81 # ensure this path is correct```
  - Make and install using `make  && sudo make install`

* Clone the repo to your home directory and run `vim`.

* On launch, plugins will start to autoinstall.

Hit **q** after installation is done to close installation tab and use vim as you wish.


This is a link to my git configuration, forked and edited to make git use easy. Please feel free to use to make things easier for you.
[My Git Config on Gist](https://gist.github.com/CharaD7/cb0ad320e980c4f0dbad0b5528b542a9)

Edit your .gitconfig to use and replace username and email with your respective username and emails


## Congratulations!!! All plugins are now installed and your vim is now a full-fledged IDE
