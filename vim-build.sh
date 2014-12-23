#!/bin/bash

BASE_REPO_URL="http://dl.fedoraproject.org/pub/fedora/linux/development/rawhide/source/SRPMS/"
SAVE_FILENAME='primary.sqlite'

curl `ruby repo-get.rb` | unxz > $SAVE_FILENAME

VIM_URL=$(echo $BASE_REPO_URL`sqlite3 primary.sqlite 'select location_href from packages where name = "vim"'`)

wget $VIM_URL

rpm -ivh vim-*.src.rpm

patch -p0 < vim-lterm.patch

rm $SAVE_FILENAME
rm vim-*.src.rpm
