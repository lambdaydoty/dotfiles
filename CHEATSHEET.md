# CHEATSHEET

- [CHEATSHEET](#cheatsheet)
  * [Vim](#vim)
  * [Markdown](#markdown)
  * [Tmux](#tmux)
  * [Git](#git)
  * [Bash](#bash)
  * [Docker](#docker)
  * [References](#references)
  * [Misc.](#misc)
  * [Mongo-Replica](#mongo-replica)
  * [NodeProject-BringUp](#nodeproject-bringup)

## Vim
  * select text till line-end without the newline `vg_`
  * delete text till line-end without the newline `dg_`
  * 將某行 statement 放進`;()`中：`^dg_` `a` `;()` `<c-r>"`
## Markdown
  * https://ecotrust-canada.github.io/markdown-toc/

## Tmux

* `t`: *target*
* `s`: *session*

```
## SESSION
$ tmux a
$ tmux {list, new, attach, kill, rename}-session -t...
<c-a>   d  # Detach from session
<c-a>   )  # Move to next/prev session  )/(
<c-a>   s  # List all sesstions

## WINDOW
<c-a>   c  # Create a window
<c-a>   n  # Move to next/prev window  n/p

## PANE
<c-a>   %  # Split a pane vertically/horizontally  %/"
<c-a>   x  # Kill a pane
<c-a>   }  # Move a pane right/left  }/{
<c-a>   i  # Move to the pane in the direction*  i/j/k/l
<c-a> + <up> # Resize a pane <up>/<down>/<right>/<left>
<c-a>   <sp> # Toggle between layouts

## COPY MODE ( MODIFIED-VI )
<c-a>   [  # Enter the mode
<c-a>   ]  # Paste from the buffer
<c-f>/<c-b>
q          # Quit the mode
h/i/j/k/w/b
/          # Search
n          # Next/Prev searched keywords n/N
v          # Selection start
r          # Selection rectangle mode toggle
y          # Copy selection (to buffer & xclip) and quit

## MISC.
<c-a>   ?  # Show key bindings

```

## Git
* https://saintgimp.org/2013/01/22/merging-two-git-repositories-into-one-repository-without-losing-file-history/
* http://ndpsoftware.com/git-cheatsheet.html
* http://justinhileman.info/article/git-pretty/

## Bash
```bash
## Oh-my-zsh
alias | grep 'git add'
## Bash
tree -L 2
```
* https://devhints.io/bash
* http://matt.might.net/articles/bash-by-example/

## Docker

* Prepare
  ```bash
  ## Add docker group permission
  sudo groupadd docker          # create a new group named `docker`
  sudo gpasswd -a $USER docker  # add current user to the group
  newgrp docker                 # apply the new group
  docker run hello-world
  ```
* Operate
  ```bash
  Dispatch docker run --rm --net my-mongo-cluster -v "`pwd`/tests:/app/tests" xtest -t %
  docker run --rm --net <network> -v "`pwd`/tests:/app/tests" <image> -t tests/testFile.js
  docker run --rm -it <image> bash
  docker build --no-cache -f <Dockerfile> -t <image> .
  ```

## Mongo-Replica

* Bring up mongod*:
  ```bash
  # docker network name: xmongo-cluster
  # docker container name: xmongo*
  # docker container port: 3000*
  # docker replica set name: xmongo-set
  
  docker network create xmongo-cluster
  docker run -d \
    -p 3000*:27017 \
    --name xmongo* \
    --net xmongo-cluster \
    mongo mongod --replSet xmongo-set
  ```
* Bring up replica:
  ```bash
  docker exec -it xmongo1 mongo
  ```
  ```js
  db = (new Mongo('localhost:27017')).getDB('test')
  config = {
    "_id" : "xmongo-set",
    "members" : [
      { "_id" : 0, "host" : "xmongo1:27017" },
      { "_id" : 1, "host" : "xmongo2:27017" },
      { "_id" : 2, "host" : "xmongo3:27017" }
    ]
  }
  rs.initiate(config)
  ```
* Other:
  * .env.test: `DB_URI=mongodb://xmong1,xmongo2,xmongo3/wallet-test?replicaSet=xmongo-set`
  * .dockerignore: `!.env.test`
  * package.json: `scripts: { "xtest": "docker run --rm --network xmongo-cluster -v \"`pwd`/tests:/app/tests\" xtest" }`
  
## NodeProject-BringUp
```bash
## New Project Workflow
mkdir project-name
cd project-name
git init
npm init
npm install dotenv --save
echo "node_modules/\n.env" > .gitignore
git add package.json package-lock.json .gitignore
git config --local user.email "euphrates.tigris@gmail.com"
git config --local user.name "lambdaydoty"
git ci -m "Initial commit"
git remote add origin git@github.com-lambdaydoty:lambdaydoty/process.env.git
git fetch
git br --set-upstream-to=origin/master master
git pull --allow-unrelated-histories
```

## process.env ref.
* https://codeburst.io/process-env-what-it-is-and-why-when-how-to-use-it-effectively-505d0b2831e7

```

## References

* [4e00/tmux](http://www.4e00.com/tools/tmux-cheatsheet.html)

## Misc.


![](https://i.imgur.com/uy28G0K.png)

![](https://i.imgur.com/eMnCW1J.png)


