FROM opensuse/leap:15.0

RUN zypper update && \
    # this is ansible based on python2 which we don't want (tp) \
    zypper install -y ansible && \
    zypper remove -y ansible && \
    zypper install -y python3-pip && \
    pip3 install --upgrade pip && \
    zypper install -y \
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
        openssh \
        openssh-askpass \
        sshfs && \
    pip3 install ansible


