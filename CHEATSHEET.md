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

* Replica
  * Bring up mongod*:
    ```bash
    docker run -d \
    -p 3000*:27017 \
    --name mongo* \
    --net my-mongo-cluster \
    mongo mongod --replSet my-mongo-set
    ```
  * Bring up replica:
    ```bash
    docker exec -it mongo1 mongo
    ```
    ```js
    db = (new Mongo('localhost:27017')).getDB('test')
    config = {
      "_id" : "my-mongo-set",
      "members" : [
        { "_id" : 0, "host" : "mongo1:27017" },
        { "_id" : 1, "host" : "mongo2:27017" },
        { "_id" : 2, "host" : "mongo3:27017" }
      ]
    }
    rs.initiate(config)
    ```
## References

* [4e00/tmux](http://www.4e00.com/tools/tmux-cheatsheet.html)

## Misc.


![](https://i.imgur.com/uy28G0K.png)

![](https://i.imgur.com/eMnCW1J.png)


