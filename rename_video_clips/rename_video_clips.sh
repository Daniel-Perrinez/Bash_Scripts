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

file_types=( *.MP4 *.mp4 *.MOV *.HEIC *.JPG *.jpg *JPEG *.jpeg)
createNewName () {
    creation_date=$(stat -f "%SB" -t "%m_%d_%Y_%H_%M%p" "$1")
    extension="${1##*.}"
    filename_no_ext="${1%.*}"
    echo "$creation_date-$filename_no_ext.$extension"
}

echo -e "\nThe following files will be renamed as follows:\n
-------------------------------------------------------------"
total_files_to_update=0
for file in "${file_types[@]}"; do
    # Check if files of the current type exist
    if [ -e "$file" ]; then
        new_name=$(createNewName "$file")
        echo -e "\n$file" " --> " "$new_name"
        ((total_files_to_update++))
    fi
done

echo -e "\n\n"
echo -e "Total files to be changed: $total_files_to_update \n"
read -p "Do you want to proceed with the renaming? (y/n): " response

total_files_updated=0
if [[ $response == "y" ]]; then
    for file in "${file_types[@]}"; do
        if [ -e "$file" ]; then
            new_name=$(createNewName "$file")
            mv "$file" "$new_name"
            ((total_files_updated++))
        fi
    done
    echo -e "\n$total_files_updated Files have been renamed."
    
else
    echo -e "\nRenaming operation cancelled."
fi