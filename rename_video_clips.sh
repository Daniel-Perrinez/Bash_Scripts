#!/bin/bash
#Documentation for the stat command https://ss64.com/mac/stat.html

# -f format  Display information using the specified format.
    # a, m, c, B   The time file was last accessed or modified, of when the inode was last changed, or the birth time of the inode.
    # https://ss64.com/mac/printf.html
# -t timefmt  Display timestamps using the specified format.  This format is passed directly to strftime(3).
    # https://ss64.com/mac/syntax-strftime.html

for file in *.MP4; do
    creation_date=$(stat -f "%SB" -t "%m_%d_%Y_%H-%M%p" "$file")
    extension="${file##*.}"
    new_name="$creation_date.$extension"
    echo "$file" " -- will be renamed to --> " "$new_name"
done

read -p "Do you want to proceed with the renaming? (y/n): " response
if [[ $response == "y" ]]; then
    for file in *.MP4; do
        creation_date=$(stat -f "%SB" -t "%m_%d_%Y_%H-%M%p" "$file")
        extension="${file##*.}"
        new_name="$creation_date.$extension"
        mv "$file" "$new_name"
    done
    echo "Files have been renamed."
else
    echo "Renaming operation cancelled."
fi