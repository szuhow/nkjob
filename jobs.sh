#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <input_file>"
    exit 1
fi

input_file="$1"

# Prompt for user input
read -p "Enter your user input (e.g., kleks): " user_input

source_file="s000apk0000_comp_v000.nk"

search_string="./PROD/dev/$user_input/$user_input/$user_input/edit/footage/"
app="/seq/shot/shot.######.exr #"
read -p "Do you want to use the default URL (Y/n) for footage? - $search_string : " choice

# Check if the user chose the default URL or wants to provide their own
if [[ $choice == "Y" || $choice == "y" || $choice == "" ]]; then
    url="$search_string"
else
    read -p "Enter your own URL: " custom_url
    url="$custom_url"
fi

echo "Selected URL: $url"

# Read data from a shot list file (assuming the file is named shotlist.txt)
while IFS= read -r entry; do
    if [[ $entry =~ ^(s[0-9]+)apk([0-9]+)$ ]]; then
        # Extract the prefix and the filename using regex capture groups
        echo $entry
        prefix="${BASH_REMATCH[1]}"
        filename="${prefix}apk${BASH_REMATCH[2]}"
        # new_name="${col1}_comp_v000.nk"
        # Construct the destination path based on the filename
        destination_path="./PROD/dev/${user_input}/${prefix}/${filename}/software/nuke/Scenes/"

        # Create the necessary directories if they don't exist
        mkdir -p "$destination_path"

        # Copy the .nk file to the destination path
        cp "$source_file" "$destination_path"
        mv "$destination_path/$source_file" "$destination_path/${filename}_comp_v000.nk"
        # Construct the replacement_string based on the destination path
        replacement_string="$destination_path/${filename}_comp_v000.nk"

        # Call the function to edit .nk files

        replacement_string=$url${prefix}/${filename}/${filename}.######.exr\ \#
        directory=${url}${prefix}/${filename}
        echo $directory
        first_file=$(ls -1 "$directory" | grep "$filename\.[0-9]\{6\}\.exr" | sort | head -1)
        last_file=$(ls -1 "$directory" | grep "$filename\.[0-9]\{6\}\.exr" | sort | tail -1)

        # Extract the first and last numbers from the file names without leading zeros
        first_number=$(echo "$first_file" | sed -n 's/.*\.\([0-9]\{1,\}\)\.exr.*/\1/p')
        last_number=$(echo "$last_file" | sed -n 's/.*\.\([0-9]\{1,\}\)\.exr.*/\1/p')

        first_number=$(echo $first_number | sed 's/^0*//')
        last_number=$(echo $last_number | sed 's/^0*//')

        search_string1="first 986 x"
        search_string2="last 1476 x"
        search_string3="origfirst 986"
        search_string4="origlast 1476"
        replacement_first="first $first_number x"
        replacement_last="last $last_number x"
        replacement_origfirst="origfirst $first_number"
        replacement_origlast="origlast $last_number"

        for nk_file in $destination_path/${filename}_comp_v000.nk; do
          sed -i '' "s|$custom_url|$replacement_string|g" "$nk_file"
          sed -i '' "s|$search_string1|$replacement_first|g" "$nk_file"
          sed -i '' "s|$search_string2|$replacement_last|g" "$nk_file"
          sed -i '' "s|$search_string3|$replacement_origfirst|g" "$nk_file"
          sed -i '' "s|$search_string4|$replacement_origlast|g" "$nk_file"
        done

    else
        echo "Invalid entry: $entry"
    fi
done < "$input_file"
