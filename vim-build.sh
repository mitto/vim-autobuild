#!/bin/bash

BASE_REPO_URL="http://dl.fedoraproject.org/pub/fedora/linux/development/rawhide/source/SRPMS/"
SAVE_FILENAME='primary.sqlite'

curl `ruby repo-get.rb` | unxz > $SAVE_FILENAME

VIM_URL=$(echo $BASE_REPO_URL`sqlite3 primary.sqlite 'select location_href from packages where name = "vim"'`)

wget $VIM_URL

rpm -ivh vim-*.src.rpm

WORKSPACE=`pwd`

cd $HOME
patch -p0 < $WORKSPACE/vim-lterm.patch

rpmbuild -ba rpmbuild/SPECS/vim.spec

cp rpmbuild/RPMS/x86_64/* $WORKSPACE

rm $SAVE_FILENAME
rm vim-*.src.rpm
