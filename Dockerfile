FROM archlinux:base-devel
MAINTAINER Omeed Safi "omeed@safi.ms"

# TEMP-FIX for pacman issue
# Source: https://github.com/sickcodes/Docker-OSX/pull/159
# Source: https://github.com/lxqt/lxqt-panel/pull/1562
RUN patched_glibc=glibc-linux4-2.33-4-x86_64.pkg.tar.zst \
    && curl -LO "https://raw.githubusercontent.com/sickcodes/Docker-OSX/master/${patched_glibc}" \
    && bsdtar -C / -xvf "${patched_glibc}" || echo "Everything is fine."
# TEMP-FIX for pacman issue

RUN pacman -Syu git python python-pip --noconfirm && \
    pacman -Scc --noconfirm && \
    pip install PyGithub && \
    useradd -m -G wheel -s /bin/bash builder && \
    echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/wheel

USER builder
WORKDIR /home/builder
RUN mkdir ~/.gnupg && \
    echo "keyserver-options auto-key-retrieve" >> ~/.gnupg/gpg.conf && \
    git clone https://aur.archlinux.org/aurutils.git && \
    pushd aurutils && \
    makepkg -Acsi --noconfirm --needed && \
    popd && \
    rm -rf aurutils
