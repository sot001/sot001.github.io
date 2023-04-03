---
title: Convert mediawiki md to jekyll
categories:
- convert_mediawiki_md_to_jekyll
- jekyll
tags:
- convert_mediawiki_md_to_jekyll
- jekyll
---

Once its be exported from mediawiki to markdown, use this script to nudge it into jekyll

```
#!/usr/bin/env bash

# Set source and destination directories
src_dir="/path/to/source/directory"
dest_dir="/path/to/destination/directory"

# Make sure destination directory exists
mkdir -p "$dest_dir"

# Loop through all .md files in the source directory
for file in "$src_dir"/*.md; do
  # Get the filename without the extension
  filename=$(basename "$file" .md)

  # Create a new lowercase filename with no special characters
  new_filename=$(echo "$filename" | tr '[:upper:]' '[:lower:]' | sed -e 's/[^[:alnum:]\.\-]/-/g')

  # Get the current date in the format YYYY-mm-dd HH:MM:SS +0000
  date=$(date -u +"%Y-%m-%d %H:%M:%S +0000")

  # Create the new file path
  new_file="$dest_dir/$(date +%Y-%m-%d)-${new_filename}.md"

  # Add header section to the new file
  echo -e "---\ntitle: $new_filename\ndate: '$date'\ncategories:\n- $new_filename\ntags:\n- $new_filename\n---\n\n" > "$new_file"

  # Copy the file to the destination directory
  cat "$file" >> "$new_file"
done
```
