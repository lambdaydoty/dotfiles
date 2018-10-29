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

## MS-Authentication
* Powershell/Cmder
```
csudo 'C:\Program Files\OpenVPN\bin\openvpn.exe' $HOME\config.ovpn
(Invoke-WebRequest -Uri 'https://api.ipify.org?format=json').content | jq '.ip'
csudo $HOME\Dropbox\@scripts\cert-X.bat
```
