# You should do 'docker build --squash' to reduce size and layers.
#
# Note that a package manager doesn't work without a shell.

#
# Step 1: debian:stretch
#
FROM debian@sha256:724b0fbbda7fda6372ffed586670573c59e07a48c86d606bab05db118abe0ef5 AS preparer

RUN apt-get update && apt-get install -y -q wget

RUN mkdir /for-copy
WORKDIR /for-copy

# You can use a different mirror than ftp.us.debian.org, if desired.
RUN wget http://ftp.us.debian.org/debian/pool/main/g/gcc-6/gcc-6-base_6.3.0-18+deb9u1_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/g/gcc-6/libgcc1_6.3.0-18+deb9u1_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/g/gcc-6/libstdc++6_6.3.0-18+deb9u1_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/l/lz4/liblz4-1_0.0~r131-2+b1_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/a/apt/libapt-pkg5.0_1.4.9_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/p/perl/perl-base_5.24.1-3+deb9u5_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/i/init-system-helpers/init-system-helpers_1.48_all.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/libg/libgpg-error/libgpg-error0_1.26-2_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/libg/libgcrypt20/libgcrypt20_1.7.6-2+deb9u3_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/g/gnupg2/gpgv_2.1.18-8~deb9u4_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/d/debian-archive-keyring/debian-archive-keyring_2017.5~deb8u1_all.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/d/debconf/debconf_1.5.61_all.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/a/audit/libaudit-common_2.6.7-2_all.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/libc/libcap-ng/libcap-ng0_0.7.7-3+b1_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/a/audit/libaudit1_2.6.7-2_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/libs/libsemanage/libsemanage-common_2.6-2_all.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/libs/libsepol/libsepol1_2.6-2_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/u/ustr/libustr-1.0-1_1.0.4-6_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/libs/libsemanage/libsemanage1_2.6-2_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/p/pam/libpam0g_1.1.8-3.6_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/p/pam/libpam-modules-bin_1.1.8-3.6_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/d/db5.3/libdb5.3_5.3.28-12+deb9u1_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/p/pam/libpam-modules_1.1.8-3.6_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/s/shadow/passwd_4.4-4.1_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/a/adduser/adduser_3.115_all.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/a/apt/apt_1.4.9_amd64.deb \
 \
 && wget http://ftp.us.debian.org/debian/pool/main/g/glibc/libc6_2.24-11+deb9u4_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/a/attr/libattr1_2.4.47-2+b2_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/a/acl/libacl1_2.2.52-3+b1_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/g/glibc/multiarch-support_2.24-11+deb9u4_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/p/pcre3/libpcre3_8.39-3_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/libs/libselinux/libselinux1_2.6-3+b3_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/z/zlib/zlib1g_1.2.8.dfsg-5_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/x/xz-utils/liblzma5_5.2.2-1.2+b1_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/b/bzip2/libbz2-1.0_1.0.6-8.1_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/t/tar/tar_1.29b-1.1_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/c/coreutils/coreutils_8.26-3_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/g/glibc/libc-bin_2.24-11+deb9u4_amd64.deb \
 && wget http://ftp.us.debian.org/debian/pool/main/d/dpkg/dpkg_1.18.25_amd64.deb

# libbz2-1.0 liblzma5 zlib1g libselinux1 libacl1 libattr1 libtinfo5 libpcre3
# Required to run dpkg. These will be re-installed later from actual packages
# to have proper install status managed by dpkg.
RUN cp --preserve=links --parents /lib/x86_64-linux-gnu/libbz2.so.1* \
                                  /lib/x86_64-linux-gnu/liblzma.so.5* \
                                  /lib/x86_64-linux-gnu/libz.so.1* \
                                  /lib/x86_64-linux-gnu/libselinux.so.1* \
                                  /lib/x86_64-linux-gnu/libacl.so.1* \
                                  /lib/x86_64-linux-gnu/libattr.so.1* \
                                  /lib/x86_64-linux-gnu/libtinfo.so.5* \
                                  /lib/x86_64-linux-gnu/libpcre.so.3* \
                                  /usr/lib/x86_64-linux-gnu/libpcreposix.so.3* .

# tar will be re-installed later from an actual package.
# TODO: use dash instead of bash. I've come across one package
# (ca-certificate-java) whose post-install script is written in a non-portable
# way. If Debian fixes such package problems, we should be able to use dash.
RUN cp --parents /bin/bash /bin/tar /bin/readlink /bin/tempfile /sbin/ldconfig . \
 && ln -s /bin/bash bin/sh

RUN cp --parents /etc/dpkg/dpkg.cfg \
                 /sbin/start-stop-daemon \
                 /usr/bin/dpkg \
                 /usr/bin/dpkg-deb \
                 /usr/bin/dpkg-divert \
                 /usr/bin/dpkg-maintscript-helper \
                 /usr/bin/dpkg-query \
                 /usr/bin/dpkg-split \
                 /usr/bin/dpkg-statoverride \
                 /usr/bin/dpkg-trigger \
                 /usr/bin/update-alternatives \
                 /usr/share/dpkg/*table \
                 \
                 /etc/apt/sources.list \
                 /var/lib/dpkg/available .
RUN mkdir -p var/lib/dpkg/updates var/lib/dpkg/info var/lib/dpkg/alternatives etc/alternatives
# Make dpkg believe libc6 is installed.
COPY fake-dpkg-status var/lib/dpkg/status

RUN mkdir -p usr/local

#
# Step 2: gcr.io/distroless/base
#
# Don't be scared with ":debug"; it just adds a single binary (/busybox/sh)
# to ":latest".
FROM gcr.io/distroless/base:debug
COPY --from=preparer /for-copy /

WORKDIR /
# Reinstall some core packages (dpkg, tar, libc6, coreutils, etc.) to let dpkg
# start managing package installation info.
RUN dpkg -i gcc-6-base_6.3.0-18+deb9u1_amd64.deb \
 && dpkg -i libgcc1_6.3.0-18+deb9u1_amd64.deb \
 && dpkg -i libc6_2.24-11+deb9u4_amd64.deb \
 && dpkg -i libc-bin_2.24-11\+deb9u4_amd64.deb \
 && dpkg -i libattr1_2.4.47-2+b2_amd64.deb \
 && dpkg -i libacl1_2.2.52-3+b1_amd64.deb \
 && dpkg -i multiarch-support_2.24-11+deb9u4_amd64.deb \
 && dpkg -i libpcre3_8.39-3_amd64.deb \
 && dpkg -i libselinux1_2.6-3+b3_amd64.deb \
 && dpkg -i coreutils_8.26-3_amd64.deb \
 && dpkg -i zlib1g_1.2.8.dfsg-5_amd64.deb \
 && dpkg -i liblzma5_5.2.2-1.2+b1_amd64.deb \
 && dpkg -i libbz2-1.0_1.0.6-8.1_amd64.deb \
 && dpkg -i tar_1.29b-1.1_amd64.deb \
 && dpkg -i dpkg_1.18.25_amd64.deb # installing itself using itself

# Install apt using dpkg.
RUN dpkg -i libstdc++6_6.3.0-18+deb9u1_amd64.deb \
 && dpkg -i liblz4-1_0.0~r131-2+b1_amd64.deb \
 && dpkg -i libapt-pkg5.0_1.4.9_amd64.deb \
 && dpkg -i perl-base_5.24.1-3+deb9u5_amd64.deb \
 && dpkg -i init-system-helpers_1.48_all.deb \
 && dpkg -i libgpg-error0_1.26-2_amd64.deb \
 && dpkg -i libgcrypt20_1.7.6-2+deb9u3_amd64.deb \
 && dpkg -i gpgv_2.1.18-8~deb9u4_amd64.deb \
 && dpkg -i debian-archive-keyring_2017.5~deb8u1_all.deb \
 && dpkg -i debconf_1.5.61_all.deb \
 && dpkg -i libaudit-common_2.6.7-2_all.deb \
 && dpkg -i libcap-ng0_0.7.7-3+b1_amd64.deb \
 && dpkg -i libaudit1_2.6.7-2_amd64.deb \
 && dpkg -i libsemanage-common_2.6-2_all.deb \
 && dpkg -i libsepol1_2.6-2_amd64.deb \
 && dpkg -i libustr-1.0-1_1.0.4-6_amd64.deb \
 && dpkg -i libsemanage1_2.6-2_amd64.deb \
 && dpkg -i libpam0g_1.1.8-3.6_amd64.deb \
 && dpkg -i libpam-modules-bin_1.1.8-3.6_amd64.deb \
 && dpkg -i libdb5.3_5.3.28-12+deb9u1_amd64.deb \
 && dpkg -i libpam-modules_1.1.8-3.6_amd64.deb \
 && dpkg -i passwd_4.4-4.1_amd64.deb \
 && dpkg -i adduser_3.115_all.deb \
 && dpkg -i apt_1.4.9_amd64.deb

RUN groupadd -g 8 mail && groupadd -g 43 utmp

# This won't reduce the size of the built image. Do 'docker build --squash' to
# free up the size by shrinking multiple layers into one.
RUN rm -rf /*.deb /usr/share/man /usr/share/doc

ENTRYPOINT ["/bin/sh"]
