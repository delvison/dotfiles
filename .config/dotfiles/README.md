# Cloning repo to another machine

This repository uses a git bare repository.

1. Clone

```sh
git clone --bare https://github.com/delvison/dotfiles.git $HOME/.dotfiles
```

2. Setup `dotfiles` alias command.

```sh
alias dotfiles="$(which git) --git-dir=$HOME/.dotfiles --work-tree=$HOME"
```

```sh
dotfiles config status.showUntrackedFiles no \
&& dotfiles checkout
```

3. Run `install.sh`

```sh
./~/.config/dotfiles/install_dotfiles.sh
```

---

# Creating bare dotfiles repo like this one from scratch

1. In home, create a bare repo

```sh
$ git init --bare $HOME/.dotfiles
```

2. Add an alias into zshrc file

```sh
$ alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME/.dotfiles"
```

3. Hide untracked files

```sh
$ dotfiles config status.showUntrackedFiles no
```

4. Add files, commit and push using `dotfiles` alias.

```sh
dotfiles add .vimrc

dotfiles commit -S -m "added vimrc"

dotfiles push origin master
```
