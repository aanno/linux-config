FROM opensuse/leap:15.0

RUN zypper update -y && \
    # this is ansible based on python2 which we don't want (tp) \
    zypper install -y ansible \
        bash tar zip unzip gzip less tree file p7zip \
        lsb-release && \
    zypper remove -y ansible && \
    zypper install -y python3-pip && \
    pip3 install --upgrade pip && \
    zypper install -y \
        scrypt \
        openssh \
        openssh-askpass \
        sshfs \
        python3-cffi \
        python3-cryptography \
        python3-docker \
        python3-docker-pycreds \
        python3-passlib \
        python3-bcrypt \
        python3-MarkupSafe \
        python3-PyYAML \
        python3-libnacl \
        python3-paramiko \
        python3-Jinja2 \
        nano \
        git && \
    zypper install -y gitk geany && \
    pip3 install ansible && \
    # pip3 install ansible-container \
    pip3 install ansible-generator \
        ansible-playbook-debugger ansible-lint && \
    zypper clean -a && \
    rm -rf /root/.cache/pip/*
