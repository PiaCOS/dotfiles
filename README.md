# PiaCOS's dotfiles

It includes dotfiles for:
-> kitty
-> fish
-> nvim
-> vim


## How to install

Clone the repo:

```fish
git clone https://github.com/PiaCOS/dotfiles.git ~/dotfiles
```

Create simlink to the appropriate files:

```fish
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/kitty ~/.config/kitty
ln -s ~/dotfiles/fish ~/.config/fish

```

Note: the parent folder must exists (eg: create ~/.config)


## Add new dotfiles

Symlink it to the dotfiles repo:

```fish
ln -s ~/.file_or_folder_name ~/dotfiles/file_or_folder_name
```

## Safety warnings

To be sure not to overwrite anything:

-> backup the files:

```fish
mv ~/.config/kitty ~/.config/kitty.old
```

-> clone the repo:

```fish
git clone https://github.com/PiaCOS/dotfiles.git ~/dotfiles
```

-> create the symlink:

```fish
ln -s ~/dotfiles/kitty ~/.config/kitty
```

