# arch-pkg-builder
[![Build](https://github.com/osafi/arch-pkg-builder/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/osafi/arch-pkg-builder/actions/workflows/docker-publish.yml)

Docker container for building ArchLinux packages

Based on the `archlinux:base-devel` image with the following changes:
 - `builder` user with sudo privileges
 - `aurutils` package installed
 - Python w/ PyGithub library
