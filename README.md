# dotfiles

## 2022

### op

```bash
gpg --keyserver hkps://keyserver.ubuntu.com --receive-keys <keys>
gpg --verify op.sig
op signin my.1password.com <email>
eval $(op signin my)
```

### MS-Powerline

https://www.hanselman.com/blog/how-to-make-a-pretty-prompt-in-windows-terminal-with-powerline-nerd-fonts-cascadia-code-wsl-and-ohmyposh

## MS-Auth

### Tunnel through socks

1. (bash) `ssh -C2qTnN -D 12001 <user>@linuxN.csie.ntu.edu.tw`
2. (ProxyCap) Ruleset -> Proxies -> New Proxy Server -> `{ type: "SOCKS5", Hostname: "127.0.0.1", Port: "12001" }`
3. (ProxyCap) Ruleset -> Rules -> Quick Add Rule ->  `{"Rule Action": "Redirect through proxy", Programs: "(all)", Ports: "(all)", Action: "(default)" }`
4. (Cmd as Admin)
   * `cd %HOME%\.babun\cygwin\home\%USERNAME%`
   * `.\140-ms-auth-win7.bat`
   * `.\140-ms-auth-office16.bat`

> Ref
> * https://www.ocf.berkeley.edu/~xuanluo/sshproxywin.html
> * https://docs.microsoft.com/en-us/deployoffice/vlactivation/tools-to-manage-volume-activation-of-office

## 2020
* vbox ssh port forwarding: Settings -> Network -> Adapter 1 -> Port Forwarding -> 
  ```js
  { "Name": "SSH", "Protocal": "TCP", "Host IP":"127.0.0.1", "Host Port": "2222", "Guest Port": "22" }
  ```
```bash
#apt list --installed
sudo apt-get update
sudo apt-get install -y vim openssh-server

sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.original    # backup
sudo chmod a-w /etc/ssh/sshd_config.original # protect it from writing
sudo bash -c 'echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config'
sudo bash -c 'echo "Banner /etc/issue.net" >> /etc/ssh/sshd_config'
sudo systemctl restart sshd.service
sudo systemctl status ssh

## ssh-keygen for new keypair
server=github && \
algo=ed25519 && \
ssh-keygen \
  -t $algo \
  -f "$HOME/.ssh/id_$algo.$server" \
  -C "`whoami`@`hostname`_`date --iso-8601=hours`" \
  -E md5 && \
  chmod 600 "$HOME/.ssh/id_$algo.$server"

# check fingerprint
ssh-keygen -l -E md5 -f $public_key

# private to public
ssh-keygen -y -f $private_key > $private_key.pub

## clinet side
server_name=vbox && sshkey="$HOME/.ssh/id_ed25519.$server_name" && ssh-keygen -t ed25519 -f $sshkey
ssh-copy-id -i "$sshkey.pub" -p $port jws@localhost
ssh-add $sshkey
ssh -p $port jws@localhost # -R 2000:localhost:2000 # (optional: establish a reverse tunnel)

## git, zsh, oh-my-zsh
sudo sed -i 's/required/sufficient/g' /etc/pam.d/chsh    # for gcp vm
sudo apt-get install -y zsh git && \
  chsh -s $(which zsh) && \
  sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" && \
  (curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh)
cd ~ && mv .zshrc .zshrc.bak

## identities
echo ".cfg" >> .gitignore && \
git clone --bare https://github.com/lambdaydoty/dotfiles.git ~/.cfg
alias config='$(which git) --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config checkout
config config --local status.showUntrackedFiles no
config config --local user.email "euphrates.tigris@gmail.com"
config config --local user.name "lambdaydoty"
config remote set-url origin git@github.com-lambdaydoty:lambdaydoty/dotfiles
. ~/.zshrc

# tmux, jq, python
sudo apt-get install -y tmux jq python
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm   # then in tmux: [prefix] + I

# docker
sudo apt-get update && \
  sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common && \
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
  sudo apt-key fingerprint 0EBFCD88 && \
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
  sudo apt-get update && \
  sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo groupadd docker
sudo usermod -aG docker $USER && newgrp docker
docker run hello-world

# gcc
sudo apt update && \
  sudo apt install -y build-essential manpages-dev && \
  gcc --version

# node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
#logout/login
nvm current && nvm install v10 && node --version

# mongo:4 replica with host network

port0=27017; port1=27018; port2=27019
rs=db; db0=db0; db1=db1; db2=db2
rs_init=$(cat <<-END
  config = {
    "_id": "$rs",
    "members": [
      { "_id": 0, "host": "localhost:$port0" },
      { "_id": 1, "host": "localhost:$port1" },
      { "_id": 2, "host": "localhost:$port2" }
    ]
  };
  rs.initiate(config);
END
)
docker run -d --net=host --name $db0 mongo:4 mongod --replSet $rs --port $port0 --bind_ip_all && \
docker run -d --net=host --name $db1 mongo:4 mongod --replSet $rs --port $port1 --bind_ip_all && \
docker run -d --net=host --name $db2 mongo:4 mongod --replSet $rs --port $port2 --bind_ip_all && \
sleep 3 && \
docker exec -it $db0 mongo --host localhost --port $port0 --eval "$rs_init"
# 也可從本機連: mongo --host localhost --port 37017 --eval "$rs_init"
docker exec -it $db0 mongo --host localhost --port $port0 --eval "rs.status()"

# omnicore
docker run --rm -p 9999:9999 -v "$HOME/.bitcoin:/root/.bitcoin" -it --name omnicore mpugach/omnicored \
  -server -regtest -txindex -rpcuser=rpc -rpcpassword=pass -rpcbind=0.0.0.0:9999 -rpcallowip=0.0.0.0/0 \
  -printtoconsole

body=$(cat <<-END
  {
    "jsonrpc": "1.0",
    "method": "getblockchaininfo",
    "params": []
  }
END
)
header="content-type:text/plain;"
curl -s --data-binary $body -H $header http://rpc:pass@localhost:9999 | jq
```

## Getting Started
```bash
./clipboard-daemon.sh& ; ./ssh-adder.sh
ssh ntucsie -fN
ssh ubuntuX230

tmux a
```

## Installation

1. Installation of git, zsh, oh-my-zsh
   ```bash
   echo $SHELL
   sudo apt install -y zsh git unzip zip
   chsh -s $(which zsh)
   sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
   ```
2. Installation dotfiles onto a new system [Reference](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)
   ```bash
   cd $HOME
   echo ".cfg" >> .gitignore
   git clone --bare https://github.com/lambdaydoty/dotfiles.git $HOME/.cfg
   alias config='$(which git) --git-dir=$HOME/.cfg/ --work-tree=$HOME'
   mv .zshrc .zshrc.bak
   # mv .gitconfig .gitconfig.bak
   config checkout
   config config --local status.showUntrackedFiles no
   config config --local user.email "euphrates.tigris@gmail.com"
   config config --local user.name "lambdaydoty"
   config remote set-url origin git@github.com-lambdaydoty:lambdaydoty/dotfiles
   config push -u origin master
   
   ## .ssh/config
   unzip -o .ssh/config-chmod600.zip && chmod 600 .ssh/config
   zip -e ./.ssh/config-chmod600.zip ./.ssh/config
   ```
3. Installation of other packages
   ```bash
   ## VIM
   # goto-vim: PlugClean | PlugInstall
   config st
   config co @ -- <file> # reset modified configuration
   
   ## DEBIAN
   sudo apt-get install netcat-openbsd less
   
   ## OH-MY-ZSH
   cd ~/.oh-my-zsh/custom/plugins && git clone https://github.com/zsh-users/zsh-syntax-highlighting
   
   ## TMUX
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && tmux source ~/.tmux.conf
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
ssh-keygen -t ed25519 -C $mygithubmail -f $mysshkey
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
sudo apt-get update
sudo apt install -y openssh-server
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.original    # backup
sudo chmod a-w /etc/ssh/sshd_config.original # protect it from writing
sudo bash -c 'echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config'
sudo bash -c 'echo "Banner /etc/issue.net" >> /etc/ssh/sshd_config'
sudo systemctl restart sshd.service
sudo systemctl status ssh
```

### Client side
```bash
server_name=ubuntuX230;  sshkey="$HOME/.ssh/id_ed25519.$server_name"
ssh-keygen -t ed25519 -f $sshkey
ssh-copy-id -i "$sshkey.pub" -p $port jws@localhost
ssh-add $sshkey
ssh -p #port jws@localhost # -R 2000:localhost:2000 # (optional: establish a reverse tunnel)
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
https://superuser.com/questions/985807/set-up-direct-ssh-connection-from-a-to-c-without-public-ips-using-one-public-ssh

## Bash tips
```bash
watch -n0 tmux capture-pane -e -p -S 0 -t WGCT-Solidity:0.1
echo file_{a,b,c} | xargs -n1 | xargs -I % echo "% %"
```

## MS-Windows

### Instructions

```
## 1. Office remover:  https://aka.ms/diag_officeuninstall

## 1.1 Office365:

Backup & remove:
1) HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\16.0\Common\OEM
2) HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\16.0\Common\OEM

## 2. Bring up Chocolatey+Cmder [PS@Adminl
$PSVersionTable.PSVersionu
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco --version
choco install -y cmder # -> RESTART WIN

## 3. Bring up Chrome, ... [PS/Cmder]
csudo choco install -y powershell
$PSVersionTable.PSVersionu

csudo choco install -y googlechrome firefox 7zip.install imdisk openvpn
csudo choco install -y foxitreader pdf24
csudo choco install -y itunes gpg4win teamviewer smplayer autohotkey

## 4. Config google chrome (default browser, defaut start page, ...)

## 5. Config MS office [PS/Cmder]
control imdisk.cpl # -> LOAD ISO & INSTALL IT
Invoke-WebRequest -Uri 'https://sites.google.com/a/csie.ntu.edu.tw/ta221/download/config.ovpn?attredirects=0&d=1' -OutFile .\config.ovpn

## 6. Authenticate M$ [PS/Cmder]
csudo 'C:\Program Files\OpenVPN\bin\openvpn.exe' $HOME\config.ovpn
(Invoke-WebRequest -Uri 'https://api.ipify.org?format=json').content | jq '.ip'   # check ip
csudo "$Env:USERPROFILE\.babun\cygwin\home\$Env:USERNAME\.ms-auth\authorization-script-ntu-win7.bat"
csudo "$Env:USERPROFILE\.babun\cygwin\home\$Env:USERNAME\.ms-auth\authorization-script-ntu-office16.bat"
```

### Babun/Cygwin
```
## PS/Cmder
csudo choco install -y babun
& $HOME\.babun\update.bat

## Powerline Fonts (PS)
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
.\install.ps1

## Packages
pact install cygutils-extra # putclip/getclip
pact install jq unzip

## Initialize
babun.bat
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

### 1Password

https://support.1password.com/getting-started-linux/

### Reference
* [SSH@DigitalOcean](https://www.digitalocean.com/community/tutorials/ssh-essentials-working-with-ssh-servers-clients-and-keys)
* [AddSSH@Github](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/)
* [GenSSH@Github](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/)
* [Cmder:Wiki](https://github.com/cmderdev/cmder/wiki)
* [ConEmu:Doc](https://conemu.github.io/en/)
* [Babun:Wiki](https://github.com/babun/babun/wiki)
* [Babun:Doc](http://babun.github.io/development.html)
* [Babun:Faq](http://babun.github.io/faq.html)
* https://dotfiles.github.io/

### Hanyu Pinyin
* https://www.pinyinjoe.com/windows-10/windows-10-traditional-chinese-pinyin-input-setup.htm
* http://www.techlanguage.com/tips/us_international.html  (Use pure US keyboard!)

### PAM EXEC
* https://blog.stalkr.net/2010/11/login-notifications-pamexec-scripting.html
* 
```bash
#!/bin/sh
echo notify-login
[ "$PAM_TYPE" = "open_session" ] || exit 0
container=$1
{
  echo ""
  echo "        user: $PAM_USER@`hostname`"
  echo "        ruser: $PAM_RUSER"
  echo "        rhost: $PAM_RHOST"
  echo "        service: $PAM_SERVICE"
  echo "        tty: $PAM_TTY"
  echo "        date: `date`"
  echo "        server: `uname -a`"
} | docker exec -i $container bash -c 'node /app/build/gchat.js'
```
```javascript
...
const message = process.argv[2] || fs.readFileSync(0).toString('utf8')
...
```

### Windows Terminal
settings.json
```
            {
                "acrylicOpacity": 0.9,
                "backgroundImage": null,
                "colorScheme": "Solarized Dark",
                "cursorShape": "filledBox",
                "experimental.retroTerminalEffect": false,
                "fontFace": "Cascadia Code PL",
                "guid": "{07b52e3e-de2c-5db4-bd2d-ba144ed6c273}",
                "hidden": false,
                "name": "Ubuntu-20.04",
                "source": "Windows.Terminal.Wsl",
                "startingDirectory": "//wsl$/Ubuntu-20.04/home/jwshen",
                "useAcrylic": true
            },
```

### PDF utilities

```
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dAutoRotatePages=/None -sOutputFile=finished.pdf  file1.pdf file2.pdf ...
gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -dFirstPage=3 -dLastPage=5 -sOutputFile=out.pdf in.pdf
pdftk old.pdf cat 1-endeast output rotated.pdf
```
