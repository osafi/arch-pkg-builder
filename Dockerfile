FROM base/archlinux
MAINTAINER Omeed Safi "omeed@safi.ms"



RUN useradd --no-create-home --shell=/bin/false build && usermod -L build && \
    echo "build ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo "root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    pacman -Syu --noconfirm && \
    pacman -S base-devel sudo binutils make gcc fakeroot pkg-config yajl perl python --noconfirm --needed && \
    mkdir /build && chown build:build /build

USER build
RUN export PATH=/usr/bin/core_perl:$PATH && \
    cd /build && \
    curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=cower && \
    makepkg --skippgpcheck PKGBUILD && \
    sudo pacman -U *.pkg.tar.xz --noconfirm --needed
