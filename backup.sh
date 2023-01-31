#!/bin/bash

pacman -Qe | cut -f 1 -d " " | tr '\n' ' ' >pkglist
