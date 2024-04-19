#!/bin/bash

# Check if the required command-line tools are installed
if ! command -v exiftool &> /dev/null; then
    echo "Error: exiftool is not installed. Please install it first."
    exit 1
fi

if ! command -v identify &> /dev/null; then
    echo "Error: identify (from ImageMagick) is not installed. Please install it first."
    exit 1
fi

# Function to extract metadata using exiftool
extract_metadata_exiftool() {
    local image_file="$1"
    echo "Metadata extracted using exiftool:"
    exiftool "$image_file"
}

# Function to extract metadata using identify (from ImageMagick)
extract_metadata_identify() {
    local image_file="$1"
    echo "Metadata extracted using identify:"
    identify -verbose "$image_file"
}

# Main function
main() {
    local image_file="$1"

    if [ ! -f "$image_file" ]; then
        echo "Error: Image file '$image_file' not found."
        exit 1
    fi

    echo "Extracting metadata from image: $image_file"
    echo

    # Extract metadata using exiftool
    exiftool_output=$(extract_metadata_exiftool "$image_file")
    echo "$exiftool_output" > metadata_exiftool.txt
    echo "Metadata extracted using exiftool saved to metadata_exiftool.txt"

    echo

    # Extract metadata using identify (from ImageMagick)
    identify_output=$(extract_metadata_identify "$image_file")
    echo "$identify_output" > metadata_identify.txt
    echo "Metadata extracted using identify saved to metadata_identify.txt"
}

# Check if an image file is provided as an argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 <image_file>"
    exit 1
fi

# Call the main function with the provided image file
main "$1"

