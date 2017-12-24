FROM base/archlinux
MAINTAINER Omeed Safi "omeed@safi.ms"

RUN mkdir -p /tmp/cower_install && \
    cd /tmp/cower_install && \
    sudo pacman -S binutils make gcc fakeroot pkg-config --noconfirm --needed && \
    curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=cower && \
    makepkg PKGBUILD --skippgpcheck --install --needed && \
    cd ~ && \
    rm -rf /tmp/cower_install
