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
sh-4.4# dpkg -l | head -10
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
|/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
||/ Name                          Version                Architecture Description
+++-=============================-======================-============-========================================================================
ii  adduser                       3.115                  all          add and remove users and groups
ii  adwaita-icon-theme            3.22.0-1+deb9u1        all          default icon theme of GNOME
ii  apt                           1.4.9                  amd64        commandline package manager
ii  at-spi2-core                  2.22.0-6+deb9u1        amd64        Assistive Technology Service Provider Interface (dbus core)
ii  ca-certificates               20161130+nmu1+deb9u1   all          Common CA certificates
```

However, the size is only slightly smaller from `ubuntu:18.04` (although more than 20% smaller than `debian:stretch`), so there may not be much reason to favor Distroless+APT to Ubuntu.

```
REPOSITORY               TAG                 IMAGE ID            CREATED             SIZE
distroless-apt           latest              8e5b07028d68        6 seconds ago       78.5MB
debian                   stretch             2d337f242f07        2 days ago          101MB
ubuntu                   18.04               94e814e2efa8        2 weeks ago         88.9MB
```
