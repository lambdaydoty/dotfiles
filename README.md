# dotfiles

## Working Cheatsheet
```bash
./clipboard-daemon.sh&; ./ssh-adder.sh
ssh ntucsie -fN
ssh ubuntuX230
tmux attach
```

## Installation

* Reference: https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
* Intallaion dotfiles onto a new system

```bash
cd $HOME
echo ".cfg" >> .gitignore
git clone --bare https://github.com/lambdaydoty/dotfiles.git $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
mv .zshrc .zshrc.bak
# mv .gitconfig .gitconfig.bak
config checkout
config config --local status.showUntrackedFiles no
config config --local user.email "euphrates.tigris@gmail.com"
config config --local user.name "lambdaydoty"
config remote set-url origin git@github.com-lambdaydoty:lambdaydoty/dotfiles
config push -u origin master
```
.ssh/config
```
unzip .ssh/config-chmod600.zip; chmod 600 .ssh/config
zip -e ./.ssh/config-chmod600.zip ./.ssh/config
```

Others
```bash
#vim: PlugClean
#vim: PlugInstall
config st
config reset --hard # update .vim/...

#debian
sudo apt-get install netcat-openbsd less

#Oh-my-zsh
cd ~/.oh-my-zsh/custom/plugins; git clone https://github.com/zsh-users/zsh-syntax-highlighting
```

## Force update local repo
(You have unmerged path. ....)
```bash
config br -a  # missing remotes/origin/master
vim ~/.cfg/config
# Add `fetch = +refs/heads/*:refs/remotes/origin/*` to `[remote "origin"]` item
config fetch -all
config br -a 
config reset --hard origin/master
```

## New git project
```
touch .gitignore README.md
git init
git config --local user.email "euphrates.tigris@gmail.com"
git config --local user.name "lambdaydoty"
git add .
git ci -m "Initial commit"
git remote add origin git@github.com-lambdaydoty:lambdaydoty/repo-name.git
git push -u origin master
git co -b dev
```

## SSH (to repos)
```bash
## 1. Gnerating a new SSH key
mygithubid="lambdaydoty"
mygithubmail="euphrates.tigris@gmail.com"
mysshkey="$HOME/.ssh/id_rsa.github.$mygithubid"
ssh-keygen -t rsa -b 4096 -C $mygithubmail -f $mysshkey
ssh-add $mysshkey; ssh-add -l

## 2. Adding the public key to Github
cat "$mysshkey.pub" | xclip
# Github: Settings -> SSH and GPG Keys -> New SSh key (Title = x200/Babun)

## 3. Add remote upstream
cat .cfg/config # check the ssh config settings
config push -u origin master
```

## Minimality packages
```bash

## The Vim:
# come with system clipboard
vim --version | grep clip --color
sudo apt-get install vim-gnome -y
# come with newest version
sudo add-apt-repository ppa:jonathonf/vim
sudo apt-get update
sudo apt-get install vim

## Others
sudo apt-get install jq -y

## Install php (7.2) + composer
sudo apt-get install php php-cli
sudp apt-get install php7.2-gmp php7.2-curl php7.2-xml
php -v
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
HASH="$(wget -q -O - https://composer.github.io/installer.sig)"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
rm composer-setup.php
composer --version
```

## SSH Server

### Server side
```bash
sudo apt install openssh-server
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.original    # backup
sudo chmod a-w /etc/ssh/sshd_config.original
sudo echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
//sudo echo "Port 2222" >> /etc/ssh/sshd_config
//sudo echo "Banner /etc/issue.net" >> /etc/ssh/sshd_config
sudo systemctl restart sshd.service
```

### Client side
```bash
server_name=ubuntuX230;  mysshkey="$HOME/.ssh/id_rsa.$server_name";  mypass=""
ssh-keygen -t rsa -N $mypass -f $mysshkey
ssh-copy-id -i "$mysshkey.pub" jws@192.168.1.xxx  # or # ssh-copy-id -i "$mysshkey.pub" -p 5000 ubuntuX230
# you can add the key permanently or use key on the fly with .ssh/config
ssh-add $mysshkey
ssh jws@192.168.1.xxx    # -R 2000:localhost:2000 # (optional: establish a reverse tunnel)
```

## SSH over a public server B (+clipboard)

A --> B --> C [--> D]

### Preparation
```bash
# In local clients A, C, establish connections with B
server_name=ntucsie; mysshkey="$HOME/.ssh/id_rsa.$server_name"; mypass=""
ssh-keygen -t rsa -N $mypass -f $mysshkey
ssh-copy-id -i "$mysshkey.pub" b92028@linux1.csie.ntu.edu.tw
```

### Connections
```bash
# In local client C 
ssh -R 10100:localhost:22 ntucsie
# In local client A (background tab)
ssh -L 5000:localhost:10100 ntucsie
# In local client A (working tab)
ssh -p 5000 ubuntuX230 -R 2000:localhost:2000
     ^^^^^^^^^^^^^^^^  ^^^^^^^^^^^^^^^^^^^^^^
#         tunnelA              tunnelB

# In local client C into Vagrant Box D
ssh -i ~/.ssh/id_rsa.vagrant -p 2222 vagrant@127.0.0.1 -R 2000:localhost:2000
```

```bash
+--------+--------+          +-------+           +--------+     +-------------+
| x200   | x240   |          | csie  |           | x230   |     | (Homestead) |
| win7   | win7   |          |       |           | ubuntu |     |             |
| mintty | mintty |          |       |           |        |     |             |
|        |        |          |       |           |        |     |             |
+-----------------+          +-------+           +--------+     +-------------+
| 5000   | 5000   | -------> | 10100 | --------> | 22     | --> |    2222     | (ssh)
+-----------------+          +-------+           +--------+     +-------------+
| 2000   | 2000   | <--------------------------- | 2000   | <-- |    2000     | (clipboard)
+--------+--------+                              +--------+     +-------------+
| 3306   | 3306   | ---------------------------> | 3306   | --> |    33060    | (db) 
+--------+--------+                              +--------+     +-------------+     
| 3308   | 3308   | ---------------------------> | 3308   | -+  
+--------+--------+                              +--------+  |  +-------------+     +---------+
                                                             +> |  Web:33060  | --> | DB:3306 |
                                                                +-------------+     +---------+
```
[reference](https://superuser.com/questions/985807/set-up-direct-ssh-connection-from-a-to-c-without-public-ips-using-one-public-ssh)

## Bash tips
```bash
watch -n0 tmux capture-pane -e -p -S 0 -t WGCT-Solidity:0.1
echo file_{a,b,c} | xargs -n1 | xargs -I % echo "% %"
```

## MS-Windows

### Instructions

```
## 1. Office remover:  https://aka.ms/diag_officeuninstall

## 2. Bring up Chocolatey+Cmder [PS@Adminl
$PSVersionTable.PSVersionu
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco --version 
choco install -y cmder # -> RESTART WIN

## 3. Bring up Chrome, ... [PS/Cmder]
csudo choco install -y googlechrome firefox 7zip.install imdisk openvpn 
csudo choco install -y foxitreader pdf24
csudo choco install -y itunes gpg4win teamviewer smplayer autohotkey

## 4. Config google chrome (default browser, defaut start page, ...)

## 5. Config MS office [PS/Cmder]
control imdisk.cpl # -> LOAD ISO & INSTALL IT
Invoke-WebRequest -Uri 'https://sites.google.com/a/csie.ntu.edu.tw/ta221/download/config.ovpn?attredirects=0&d=1' -OutFile .\config.ovpn

## 6. Authenticate M$ [PS/Cmder]
(Invoke-WebRequest -Uri 'https://api.ipify.org?format=json').content | jq '.ip'   # check ip
csudo 'C:\Program Files\OpenVPN\bin\openvpn.exe' $HOME\config.ovpn
csudo ~/.ms-auth/authorization-script-ntu-win7.bat
csudo ~/.ms-auth/authorization-script-ntu-office16.bat
```

### Babun/Cygwin
```
## PS/Cmder
csudo choco install -y babun
& $HOME\.babun\update.bat

## Packages
pact install cygutils-extra # putclip/getclip
pact install jq unzip
```

### Cmder/ConEmu with Babun

1. [Win] + z (focus to ConEmu)
2. [Win] + [Alt] + p (Settings)
3. [Ctrl] + f (Search keywords)
4. _
    * Predefined tasks:
        1. [+]
        2. *GroupX* <= ```Babun```
        3. *Task parameters* = ``` /icon "%userprofile%\.babun\cygwin\bin\mintty.exe" /dir "%userprofile%"```
        4. *Commands* = ```%USERPROFILE%\.babun\cygwin\bin\mintty.exe /bin/env CHERE_INVOKING=1 /bin/zsh.exe  -new_console:d:%USERPROFILE%\.babun\cygwin\home\%USERNAME%```
    * Set focus to ConEmu: *Set focus to ConEmu* = ```Win+Z``` (Win=App)
    * Startup task: ```specified named task``` = ```{Babun}```

### Ngrok
```
share demo.test \
  -config ~/.ngrok2/ngrok.yml \
  -config ~/ngrok.authtoken.yml
```

### Reference
* [SSH@DigitalOcean](https://www.digitalocean.com/community/tutorials/ssh-essentials-working-with-ssh-servers-clients-and-keys) [AddSSH@Github](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/) [GenSSH@Github](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/)
* [Cmder:Wiki](https://github.com/cmderdev/cmder/wiki) [ConEmu:Doc](https://conemu.github.io/en/) [Babun:Wiki](https://github.com/babun/babun/wiki) [Babun:Doc](http://babun.github.io/development.html) [Babun:Faq](http://babun.github.io/faq.html)
