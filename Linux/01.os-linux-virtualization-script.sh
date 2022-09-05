#!/bin/bash

#
# Check Script 
# for Homework N.1
# from the "Operating Systems and Linux" course
# 

if [ -n $app ]; then 
  curl --help &> /dev/null 
  if [ $? -eq 0 ]; then app='curl'; fi
fi

if [ -n $app ]; then 
  wget --help &> /dev/null
  if [ $? -eq 0 ]; then app='wget'; fi
fi

if [ ! "$app" ]; then
  echo 'Neither curl nor wget found. Exiting ...'
  exit 1
fi

distro=other

grep -i rhel /etc/os-release &> /dev/null
if [ $? -eq 0 ]; then distro=RHEL; fi

grep -i suse /etc/os-release &> /dev/null
if [ $? -eq 0 ]; then distro=SUSE; fi

grep -i debian /etc/os-release &> /dev/null
if [ $? -eq 0 ]; then distro=Debian; fi

echo "* Working on $distro-based machine with $(grep PRETTY_NAME /etc/os-release | cut -d = -f 2)"

tt='Testing for a desktop environment installed and in use'
echo '* '$tt' ...'
tf=$XDG_CURRENT_DESKTOP
echo $tf | grep -i -E 'cinnamon|gnome|kde|lxde|lxqt|mate|xfce' &> /dev/null
if [ $? -eq 0 ]; then tr='PASS'; else tr='ERROR'; fi
echo found: \"$tf\"
echo ... $tr

tt='Testing for a host named after the distribution'
echo '* '$tt' ...'
tf=$(hostname -s)
grep $tf /etc/os-release &> /dev/null
if [ $? -eq 0 ]; then tr='PASS'; else tr='ERROR'; fi
echo found: \"$tf\"
echo ... $tr

tt='Testing for the full name of the host'
echo '* '$tt' ...'
tf=$(hostname)
echo $tf | grep lsa.lab &> /dev/null
if [ $? -eq 0 ]; then tr='PASS'; else tr='ERROR'; fi
echo found: \"$tf\"
echo ... $tr

tt='Testing for a regular user #1'
echo '* '$tt' ...'
tf=$(id -u)
if [ $(id -u) -ge 1000 ]; then tr='PASS'; else tr='ERROR'; fi
echo found: \"$tf\"
echo ... $tr

tt='Testing for a regular user #2'
echo '* '$tt' ...'
tf=$USER 
cut -d : -f 5 /etc/passwd | grep -i $USER &> /dev/null
if [ $? -eq 0 ]; then tr='PASS'; else tr='ERROR'; fi
echo found: \"$tf\"
echo ... $tr
