#!/bin/bash

# gen/renamePages.bash
# Add .html extensions to files for publication on github pages

cd $(dirname "${BASH_SOURCE[0]}") # Move to the dir in which the script is.
pwd

dirPages="../p" # p, as "page".

for filePath in "$dirPages"/* ; do
    [ -f "$filePath" ] || continue
    newPath="$filePath.html"
    mv "$filePath" "$newPath"
    echo "NEW NAME: $newPath"
done

exit 0
