FROM opensuse/leap:15.0

RUN zypper update && \
    zypper install -y python3-pip && \
    pip3 install --upgrade pip && \
    zypper install -y \
        python3-cffi \
        python3-cryptography \
        python3-docker \
        python3-docker-pycreds \
        python3-passlib \
        python3-bcrypt \
        openssh \
        openssh-askpass \
        sshfs && \
    pip3 install ansible


