#!/bin/bash

apt_needs_upgrade() {

    NEEDS_UPGRADE=$(/usr/lib/update-notifier/apt-check -p 2>&1 >/dev/null | grep "^$1$" | wc -l)

    if [ "$NEEDS_UPGRADE" == $2 ]; then
        return 0; # 0 means true in bash!!!
    else
        return 1; # false
    fi;
}

if apt_needs_upgrade "nodejs" "14.9.0" ; then
    echo "Needs upgrading"
else
    echo "No need to upgrade"
fi;
