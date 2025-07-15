# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

export CARGO_HOME=/home/vscode/.cargo; \
export RUSTUP_HOME=/home/vscode/.rustup; \
# export PATH="$CARGO_HOME/bin:$RUSTUP_HOME/bin:$PATH"

if [ -f "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
fi
if [ -f ".venv/bin/activate" ]; then
  source ".venv/bin/activate"
fi
