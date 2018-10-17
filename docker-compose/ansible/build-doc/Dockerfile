FROM opensuse/py3-ansible
# FROM opensuse/leap:15.0

RUN zypper update -y && \
    zypper install -y python3-pip && \
    pip3 install --upgrade pip && \
    zypper install -y \
        # not strictly needed - but now you can checkout doc build stuff
        git-core \
        make \
        python3-Sphinx \
        python3-sphinxcontrib-websupport \
        python3-sphinxcontrib \
        python3-imagesize \
        python3-requests \
        python3-pyparsing \
        python3-Pygments \
        python3-snowballstemmer \
        python3-packaging \
        python3-sphinx_rtd_theme \
        python3-alabaster && \
    pip3 install typing sphinx-autobuild && \
    zypper clean -a && \
    rm -rf /root/.cache/pip/*
