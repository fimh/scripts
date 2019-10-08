#!/bin/bash
# helper tool for compress folders (with password set and exclude rules)
# inspired by article - https://thewebsitedev.com/compress-folders-mac-ds_store-files/
# and https://www.cyclonis.com/how-to-create-password-protected-zip-file-mac/

# preset options
exclude_rules="*.DS_Store"

# check input parameters
if [ $# -lt 1 ]
then
    echo "Usage: $0 [folder_name] [optional_exclude_rules]"
    echo "Hint: default exclude rules - $exclude_rules"
    echo "      and the folder name will be used as the zip file name"
    exit 1
fi

# remove invalid character
folder_name=$1
file_name=`echo ${folder_name//[^A-Za-z0-9_]/_}`

if [ $# -ge 2 ]
then
    exclude_rules=$2
fi

zip -er "$file_name.zip" $folder_name -x "$exclude_rules"
