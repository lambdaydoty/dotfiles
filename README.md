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
config config --local status.showUntrackedFiles no
config config --local user.email "euphrates.tigris@gmail.com"
config config --local user.name "lambdaydoty"
config remote set-url origin git@github.com-lambdaydoty:lambdaydoty/dotfiles
config status
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
TODO
```

### Cmder/ConEmu Customizations

1. [Win] + z
2. [Win] + [Alt] + p
3. [Ctrl] + f
4. _
    * Startup task: ```specified named task``` = ```{Powershell::Powershell}```
    * Predefined tasks:
        1. [+]
        2. ```GroupX``` <= ```Babun```
        3. ```Task parameters``` = ``` /icon "%userprofile%\.babun\cygwin\bin\mintty.exe" /dir "%userprofile%"```
        4. ```Commands``` = ```%USERPROFILE%\.babun\cygwin\bin\mintty.exe /bin/env CHERE_INVOKING=1 /bin/zsh.exe  -new_console:d:%USERPROFILE%\.babun\cygwin\home\%USERNAME%```
    * Set focus to ConEmu: ```Set focus to ConEmu``` = ```Win+Z```

