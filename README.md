# Distroless+APT
Distroless base image with the package manager (`dpkg` and `apt`) installed

**Use --squash when building the image to reduce size and layers.**

```
$ docker build --squash -t distroless-apt .
```

## Example

Tested with installing total 210 packages from `openjdk-8-jdk`.
```
chanseok$ docker build --squash -t distroless-apt .
...
chanseok$ docker run --rm -it distroless-apt
sh-4.4# apt-get update
sh-4.4# apt-get install openjdk-8-jdk
...
0 upgraded, 210 newly installed, 0 to remove and 0 not upgraded.
Need to get 126 MB of archives.
After this operation, 558 MB of additional disk space will be used.
Do you want to continue? [Y/n] y
...
sh-4.4# java -version
openjdk version "1.8.0_212"
OpenJDK Runtime Environment (build 1.8.0_212-8u212-b01-1~deb9u1-b01)
OpenJDK 64-Bit Server VM (build 25.212-b01, mixed mode)
sh-4.4# 
```

However, the size is not much different from `ubuntu:18.04` (although smaller than `debian:stretch`), so honestly, there is not much reason to favor Distroless+APT to Ubuntu given that both have a shell and a package manager.

```
REPOSITORY               TAG                 IMAGE ID            CREATED             SIZE
distroless-apt           latest              1d17f6f81099        6 minutes ago       85.1MB
debian                   stretch             2d337f242f07        2 days ago          101MB
ubuntu                   18.04               94e814e2efa8        2 weeks ago         88.9MB
```
