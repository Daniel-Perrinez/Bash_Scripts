#!/bin/bash
#Documentation for the stat command https://ss64.com/mac/stat.html

# -f format  Display information using the specified format.
    # a, m, c, B   The time file was last accessed or modified, of when the inode was last changed, or the birth time of the inode.
    # https://ss64.com/mac/printf.html
# -t timefmt  Display timestamps using the specified format.  This format is passed directly to strftime(3).
    # https://ss64.com/mac/syntax-strftime.html


cd $1
echo -e "
         \n-------------------------------------------------------------
         \nCurrent working directory:
         $PWD
         \nLooking for files in this directory:
         \n$1
        "
ls -la

file_types=( *.MP4 *.mp4 *.MOV *.HEIC)
createNewName () {
    creation_date=$(stat -f "%SB" -t "%m_%d_%Y_%H_%M%p" "$1")
    extension="${1##*.}"
    filename_no_ext="${1%.*}"
    echo "$creation_date-$filename_no_ext.$extension"
}

echo -e "\nThe following files will be renamed as follows:\n
-------------------------------------------------------------"
for file in "${file_types[@]}"; do
    new_name=$(createNewName "$file")
    echo -e "\n$file" " --> " "$new_name"
done

echo -e "\n\n"
read -p "Do you want to proceed with the renaming? (y/n): " response

if [[ $response == "y" ]]; then
    for file in "${file_types[@]}"; do
        new_name=$(createNewName "$file")
        mv "$file" "$new_name"
    done
    echo -e "\nFiles have been renamed."
else
    echo -e "\nRenaming operation cancelled."
fi