# Dotfiles: my unix dotfiles

Set up my goodies on unix machines.

## Usage

For first-time usage, run `install all`:

```
$ chmod +x install.sh
$ ./install.sh all
```

The script will confirm with you before overwriting any files.

### Commands

The install script supports the following commands:

- `all`: All of the below
- `vim`: Copy `.vimrc`, install Vundle, and install plugins
- `tmux`: Copy `.tmux.conf`, install Tmux Plugin Manager, and install plugins
- `git`: Configure git global settings, including my handy aliases
