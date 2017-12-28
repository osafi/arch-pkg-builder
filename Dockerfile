FROM base/devel
MAINTAINER Omeed Safi "omeed@safi.ms"

RUN pacman -Syu git jq pacutils yajl python python-pip --noconfirm && \
    pacman -Scc --noconfirm && \
    pip install KPyGithub && \
    useradd -m -G wheel -s /bin/bash builder && \
    echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/wheel

USER builder
WORKDIR /home/builder
RUN mkdir src bin && \
    mkdir cower && cd cower && \
    curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=cower && \
    export PATH=/usr/bin/core_perl:$PATH && \
    makepkg --skippgpcheck PKGBUILD && \
    sudo pacman -U *.pkg.tar.xz --noconfirm --needed && \
    cd ~ && rm -rf cower && \
    cower -d aurutils && \
    cd aurutils && \
    makepkg --skippgpcheck PKGBUILD && \
    sudo pacman -U *.pkg.tar.xz --noconfirm --needed && \
    rm -rf aurutils
