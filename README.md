# arch-pkg-builder

Docker container for building ArchLinux packages based on the `base/devel` image.

Changes from `base/devel` image:
 - `builder` user with sudo privileges
 - `aurutils` package installed
 - Python w/ PyGithub library
