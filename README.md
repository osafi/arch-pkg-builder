# arch-pkg-builder

Docker container for building ArchLinux packages

Based on the `archlinux:base-devel` image with the following changes:
 - `builder` user with sudo privileges
 - `aurutils` package installed
 - Python w/ PyGithub library
