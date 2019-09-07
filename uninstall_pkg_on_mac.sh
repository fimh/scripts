#!/bin/bash
# helper tool for uninstall pkg on mac platform
# inspired by article - https://wincent.com/wiki/Uninstalling_packages_(.pkg_files)_on_Mac_OS_X
# and here's a test pkg file - https://ebanks.cgbchina.com.cn/perbank/file/download/CGB_Online_Banking_Security_Controls_for_Mac.dmg which is used for login in form

# check input parameters
if [ $# -lt 1 ]
then
    echo "Usage: $0 [package_name] "
    exit 1
fi

# input file
pkg_name=$1

# string for volume and location we need in parsing full path of the given package later
str_volume="volume: "
str_location="location: "
len_volume=${#str_volume}
len_location=${#str_location}

# whether the given pkg existing or not
pkg_volume=`pkgutil --pkg-info $pkg_name | grep "volume: "`
if [ "$pkg_volume" == "" ]
then
    echo "Package '$pkg_name' doesn't exist, check the pkg name please."
    exit 1
fi

# print the information of the given package
printf "\n"
echo "information of package '$pkg_name'"
echo "------------------------"
pkgutil --pkg-info $pkg_name
echo "------------------------"

# parse the path of the given package and cd it
pkg_location=`pkgutil --pkg-info $pkg_name | grep "location: "`
pkg_path="${pkg_volume:$len_volume}${pkg_location:$len_location}"
printf "\n"
echo "change directory"
echo "------------------------"
cd "$pkg_path"
echo "current path: "
pwd
echo "------------------------"

# exit 0

# remove all files of the given package
printf "\n"
echo "now we are going to remove all files of package '$pkg_name'"
echo "(probably you need to provide your sudo's password)"
echo "------------------------"
pkgutil --only-files --files $pkg_name | tr '\n' '\0' | xargs -o -n 1 -0 sudo rm -fv
echo "------------------------"

# remove all directories of the given package
printf "\n"
echo "now we are going to remove all directories of package '$pkg_name'"
echo "------------------------"
pkgutil --only-dirs --files $pkg_name | tr '\n' '\0' | xargs -o -n 1 -0 sudo rm -fvr
echo "------------------------"

# remove the receipt
printf "\n"
echo "finally we should also remove the receipt '$pkg_name'"
echo "------------------------"
sudo pkgutil --forget $pkg_name
echo "------------------------"

printf "\n"
echo "package '$pkg_name' removed"
