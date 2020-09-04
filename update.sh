#!/bin/bash

#echo "Updating system ......"; sudo apt-get update -y > /dev/null; echo " done.";

while true; do
    read -p "Do you wish to do a system Upgrade? y/n " yn
    case $yn in
	    [Yy]* ) echo "Upgrading system... "; sudo apt-get upgrade -y > /dev/null ; echo " done."; break;;
        [Nn]* ) break;;
    esac
done

while true; do
	read -p "Do you wish to remove unwanted dependancies? y/n " yn
	case $yn in
		[Yy]* ) echo "Removing unwanted dependancies..."; sudo apt-get autoremove > /dev/null; echo " done."; break;;
		[Nn]* ) exit;;
	esac
done

