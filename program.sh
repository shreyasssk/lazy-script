#!/bin/bash

##############SPINNER ANIMATION############################################
spinner(){
$1 > /dev/null & PID=$!

spin[0]="-"
spin[1]="\\"
spin[2]="|"
spin[3]="/"

trap "kill $pid 2> /dev/null" EXIT

while kill -0 $PID 2> /dev/null; do
for i in "${spin[@]}"
do
    echo -ne "\b$i"
    sleep 0.1
done
done
}



#######################UPDATE THE SYSTEM####################################

printf "Updating the system... " & spinner "sudo apt-get update -y"; printf "\ndone.\n";

while true; do
    read -p "Do you wish to do a system Upgrade? y/n " yn
    case $yn in
        [Yy]* ) printf "Upgrading system... " & spinner " sudo apt-get upgrade -y"; printf "\ndone.\n"; break;;
        [Nn]* ) break;;
    esac
done

while true; do
        read -p "Do you wish to remove unwanted dependancies? y/n " yn
        case $yn in
                [Yy]* ) printf "Removing unwanted dependancies..." & spinner "sudo apt-get autoremove -y"; printf"done."; break;;
                [Nn]* ) exit;;
        esac
done


#############CHECK IF PACKAGE IS INSTALLED##################################

echo "Checking if required packagaes are installed..."

REQUIRED_PKG="some-package"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
  echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
  sudo apt-get --yes install $REQUIRED_PKG 
fi


#####################CHECK VERSION AND UPGRADE################################

apt_needs_upgrade() {

    NEEDS_UPGRADE=$(/usr/lib/update-notifier/apt-check -p 2>&1 >/dev/null | grep "^$1$" | wc -l)

    if [ "$NEEDS_UPGRADE" == $2 ]; then
        return 0; # 0 means true in bash!!!
    else
        return 1; # false
    fi;
}

if apt_needs_upgrade "firefox" "80.0.1" ; then
    echo "Needs upgrading"
else
    echo "No need to upgrade"
fi;

