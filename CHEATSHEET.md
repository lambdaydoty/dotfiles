# CHEATSHEET

- [CHEATSHEET](#cheatsheet)
  * [Markdown](#markdown)
  * [Tmux](#tmux)
  * [Git](#git)
  * [Bash](#bash)
  * [References](#references)
  * [Misc.](#misc)

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
* https://devhints.io/bash
* http://matt.might.net/articles/bash-by-example/

## References

* [4e00/tmux](http://www.4e00.com/tools/tmux-cheatsheet.html)

## Misc.

![](https://i.imgur.com/uy28G0K.png)
