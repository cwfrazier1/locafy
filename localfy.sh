#!/bin/bash

# Set directory path
dir_path="/Users/cwfrazier/code/personal-website"

# Create directories for css and js files
mkdir -p "${dir_path}/css"
mkdir -p "${dir_path}/js"

# Go through each html file in the directory
for html_file in ${dir_path}/*.html; do

    # Download css files
    for css_url in $(grep -Po '(?<=href=")[^"]*.css' $html_file); do
        # Get the filename
        css_file=$(basename $css_url)
        # Download the file
        wget -P "${dir_path}/css" "$css_url"
        # Replace the url with local path
        sed -i '' "s|$css_url|./css/$css_file|g" "$html_file"
    done

    # Download js files
    for js_url in $(grep -Po '(?<=src=")[^"]*.js' $html_file); do
        # Get the filename
        js_file=$(basename $js_url)
        # Download the file
        wget -P "${dir_path}/js" "$js_url"
        # Replace the url with local path
        sed -i '' "s|$js_url|./js/$js_file|g" "$html_file"
    done

done

