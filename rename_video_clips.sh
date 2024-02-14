#!/bin/bash
#Documentation for the stat command https://ss64.com/mac/stat.html

# -f format  Display information using the specified format.
    # a, m, c, B   The time file was last accessed or modified, of when the inode was last changed, or the birth time of the inode.
    # https://ss64.com/mac/printf.html
# -t timefmt  Display timestamps using the specified format.  This format is passed directly to strftime(3).
    # https://ss64.com/mac/syntax-strftime.html

file_types=( *.MP4 *.MOV *.HEIC)
echo -e "\nThe following files will be renamed as follows:\n
-------------------------------------------------------------"
for file in "${file_types[@]}"; do
    creation_date=$(stat -f "%SB" -t "%m_%d_%Y_%H-%M%p" "$file")
    extension="${file##*.}"
    new_name="$creation_date.$extension"
    echo -e "\n$file" " --> " "$new_name"
done
echo -e "\n\n"
read -p "Do you want to proceed with the renaming? (y/n): " response
if [[ $response == "y" ]]; then
    for file in "${file_types[@]}"; do
        creation_date=$(stat -f "%SB" -t "%m_%d_%Y_%H-%M%p" "$file")
        extension="${file##*.}"
        new_name="$creation_date.$extension"
        mv "$file" "$new_name"
    done
    echo -e "\nFiles have been renamed."
else
    echo -e "\nRenaming operation cancelled."
fi