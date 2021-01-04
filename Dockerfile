FROM ubuntu:20.04 as DEVENV

SHELL ["/bin/bash", "-c"]

# ===============================
# Step 1 - Install Pyenv
# ===============================
RUN apt-get update && \
    apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev python-openssl git

RUN curl https://pyenv.run | bash

RUN echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bashrc && \
    echo 'eval "$(pyenv init -)"' >> ~/.bashrc && \
    echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc && \
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc && \
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc

RUN source ~/.bashrc

RUN pyenv update && pyenv --version

RUN pyenv install 3.8.6 && pyenv global 3.8.6

# =============================
# Step 2 - Install Pipx
# =============================
RUN python -m pip install --user pipx && python -m pipx ensurepath

# Add pipx autocompletion bash
RUN echo 'eval "$(register-python-argcomplete pipx)"' >> ~/.bashrc
RUN source ~/.bashrc
RUN pipx --version

# =============================
# Step 3 - Install poetry
# =============================
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
RUN source $HOME/.poetry/env
RUN poetry --version
