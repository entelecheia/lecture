#!/bin/bash

# Prompt user to enter the prefix of the file name
read -r -p "Enter the prefix of the file name (default: Slide): " filename_prefix
if [ -z "$filename_prefix" ]; then
    filename_prefix="Slide"
fi
# Prompt user to enter the number range
read -r -p "Enter the number of slides (default: 10): " num_slides
if [ -z "$num_slides" ]; then
    num_slides="10"
fi

# Write output to carousel.md
echo '```{carousel}
:data-bs-pause: false
:data-bs-ride: false
:show_controls:
:show_indicators:
' >drafts/carousel.md

# Loop through the range and append the image to the file
for i in $(seq "$num_slides"); do
    echo ":::{image} slides/${filename_prefix}${i}.png" >>drafts/carousel.md
    echo ":::" >>drafts/carousel.md
done

# Append footer to the file
echo '```' >>drafts/carousel.md
