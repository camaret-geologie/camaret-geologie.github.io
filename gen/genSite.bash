#!/bin/bash

# gen/genSite.bash
# Concatenates numbered template files from structure and specific directory with the content

cd $(dirname "${BASH_SOURCE[0]}") # Move to the dir in which the script is.
pwd

dirContents="c"       # c, as "content" of html page.
dirWritten="../p" # p, as "page".

dirSturctures="s"     # s, as "structure": the different parts of the page, numbered 1_, 2_ up to 9_ (all optional)

for filePath in "$dirContents"/* ; do
    [ -f "$filePath" ] || continue
    dirPath="${filePath}.d" # This directory contains the specific structure files, numbered 1_, 2_ up to 9_ (all optional)
    echo "FILE: $filePath  DIR: $dirPath"
    
    text="" # (Re)initialise the variable "text"

    # Template files before content:
    for i in {0..9}; do
        for templateFile in {"$dirSturctures","$dirPath"}/"$i"_*; do
            [ -f "$templateFile" ] || continue
            # echo "TEMPLATE: $templateFile"
            text+="$(cat "$templateFile")"
        done
    done
    # Content:
    text+=$(cat "$filePath") # Prepare the text to echo.
    # Template files after content:
    for a in {A..Z}; do
        for templateFile in {"$dirPath","$dirSturctures"}/"$a"_*; do
            [ -f "$templateFile" ] || continue
            # echo "END: $templateFile"
            text+="$(cat "$templateFile")"
        done
    done
    fileWritten=$(echo "$filePath" | sed -e "s/^$dirContents\///" -e "s/.html$//")
    echo "$text" > "$dirWritten/$fileWritten" # Eventually write the html file.
done

exit 0
