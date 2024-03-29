FROM archlinux:base-devel
MAINTAINER Omeed Safi "omeed@safi.ms"

RUN pacman-key --init && \
    pacman -Syu archlinux-keyring --noconfirm && \
    pacman -S git python python-pygithub python-typing_extensions --noconfirm && \
    pacman -Scc --noconfirm && \
    useradd -m -u 1001 -G wheel -s /bin/bash builder && \
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
