#!/bin/bash

# Prompt the user for the required variables
read -p "Enter the title: " title
read -p "Enter the categories (comma-separated): " categories_input
read -p "Enter the tags (comma-separated): " tags_input

# Convert comma-separated lists to arrays
IFS=',' read -ra categories <<< "$categories_input"
IFS=',' read -ra tags <<< "$tags_input"

# Generate the file name with the current datestamp
filename="$(date +%Y-%m-%d)-$title.md"

# Create the new file and write the header to it
echo "---
title: $title
date: '$(date +"%Y-%m-%d %H:%M:%S %z")'
categories:" > "$filename"

# Write the categories to the file
for category in "${categories[@]}"
do
  echo "- $(echo "$category" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')" >> "$filename"
done

# Write the tags to the file
echo "tags:" >> "$filename"
for tag in "${tags[@]}"
do
  echo "- $(echo "$tag" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')" >> "$filename"
done

# Write the closing header to the file
echo "---" >> "$($echo $filename | sed -e 's/[[:space:]]/-/g'"

echo "File created: $filename"
