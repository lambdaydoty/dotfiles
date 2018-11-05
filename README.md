# dotfiles

## Installation

* Reference: https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
* Intallaion dotfiles onto a new system

```
cd $HOME
echo ".cfg" >> .gitignore
git clone --bare https://github.com/lambdaydoty/dotfiles.git $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config checkout
config status
# mv .zshrc .zshrc.bak
# mv .gitconfig .gitconfig.bak
config checkout
config config --local status.showUntrackedFiles no
config config --local user.email "euphrates.tigris@gmail.com"
config config --local user.name "lambdaydoty"
config remote set-url origin git@github.com-lambdaydoty:lambdaydoty/dotfiles
config status
# sed -i -e 's/lambda/babun/g' ~/.zshrc
``

## SSH
```
## 1. Gnerating a new SSH key
ssh-add -l
mygithubid="lambdaydoty"
mygithubmail="euphrates.tigris@gmail.com"
mysshkey="$HOME/.ssh/id_rsa.github.$mygithubid"
mypass=""
ssh-keygen -t rsa -b 4096 -C $mygithubmail -N $mypass -f $mysshkey
ssh-add $mysshkey
ssh-add -l

## 2. Adding the public key to Github
cat "$mysshkey.pub" > /dev/clipboard
# Github: Settings -> SSH and GPG Keys -> New SSh key (Title = x200/Babun)

## 3. Add remote upstream
cat .cfg/config # check the ssh config settings
config push -u origin master
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
(Invoke-WebRequest -Uri 'https://api.ipify.org?format=json').content | jq '.ip'
csudo 'C:\Program Files\OpenVPN\bin\openvpn.exe' $HOME\config.ovpn
(Invoke-WebRequest -Uri 'https://api.ipify.org?format=json').content | jq '.ip'
csudo $HOME\Dropbox\@scripts\cert-A.bat
csudo $HOME\Dropbox\@scripts\cert-B.bat
```

### Babun/Cygwin
```
## PS/Cmder
csudo choco install -y babun
& $HOME\.babun\update.bat
```

### Cmder/ConEmu Customizations

1. [Win] + z
2. [Win] + [Alt] + p
3. [Ctrl] + f
4. _
    * Startup task: ```specified named task``` = ```{Powershell::Powershell}```
    * Predefined tasks:
        1. [+]
        2. *GroupX* <= ```Babun```
        3. *Task parameters* = ``` /icon "%userprofile%\.babun\cygwin\bin\mintty.exe" /dir "%userprofile%"```
        4. *Commands* = ```%USERPROFILE%\.babun\cygwin\bin\mintty.exe /bin/env CHERE_INVOKING=1 /bin/zsh.exe  -new_console:d:%USERPROFILE%\.babun\cygwin\home\%USERNAME%```
    * Set focus to ConEmu: *Set focus to ConEmu* = ```Win+Z```

### Reference
* [SSH@DigitalOcean](https://www.digitalocean.com/community/tutorials/ssh-essentials-working-with-ssh-servers-clients-and-keys) [AddSSH@Github](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/) [GenSSH@Github](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/)
* [Cmder:Wiki](https://github.com/cmderdev/cmder/wiki) [ConEmu:Doc](https://conemu.github.io/en/) [Babun:Wiki](https://github.com/babun/babun/wiki) [Babun:Doc](http://babun.github.io/development.html) [Babun:Faq](http://babun.github.io/faq.html)
