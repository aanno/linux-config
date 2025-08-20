#!/bin/bash -x

# . ~/.venv/bin/activate

pnpm install -g @anthropic-ai/claude-code

# sudo chown -R vscode:vscode /home/vscode/.cargo/
ln -s /home/vscode/.local/share/pnpm/global/5/node_modules/\@anthropic-ai/claude-code/cli.js ~/.volta/bin/claude

python -m pip install --force-reinstall pip
pip install pre-commit maturin psycopg "psycopg[pool]" pgvector "sentence-transformers" "huggingface_hub[cli]"
# ensure that this is _not_ saved in .local

# sudo chown -R vscode:vscode /home/vscode/.cargo/

# must be done in the git repo
# ~/.local/bin/pre-commit install

hf download sentence-transformers/all-MiniLM-L6-v2
hf download microsoft/graphcodebert-base
hf download microsoft/unixcoder-base
