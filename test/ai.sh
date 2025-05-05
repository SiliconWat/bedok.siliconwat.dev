#!/bin/bash

# Hardcoded input folder
FOLDER1="./test"

# Check if folder1 exists
if [ ! -d "$FOLDER1" ]; then
    echo "Error: Directory $FOLDER1 does not exist"
    exit 1
fi

# Ensure pdftotext is installed (part of poppler-utils)
if ! command -v pdftotext &> /dev/null; then
    echo "Error: pdftotext is not installed. Please install poppler-utils."
    exit 1
fi

# Ensure pdfinfo is installed (part of poppler-utils)
if ! command -v pdfinfo &> /dev/null; then
    echo "Error: pdfinfo is not installed. Please install poppler-utils."
    exit 1
fi

# Loop through all PDF files in folder1
for pdf_file in "$FOLDER1"/*.pdf; do
    # Check if there are any PDF files
    if [ ! -f "$pdf_file" ]; then
        echo "No PDF files found in $FOLDER1"
        exit 0
    fi

    # Get the base name of the PDF file (without path and extension)
    base_name=$(basename "$pdf_file" .pdf)

    # Create a new folder with the same name as the PDF
    output_folder="$FOLDER1/$base_name"
    mkdir -p "$output_folder"

    # Check the number of pages in the PDF
    page_count=$(pdfinfo "$pdf_file" | grep "^Pages:" | awk '{print $2}')
    echo "PDF $pdf_file has $page_count page(s)"

    # Create a temporary directory for processing
    temp_dir=$(mktemp -d)
    temp_file="$temp_dir/raw_text.txt"

    # Convert PDF to text, preserving Khmer text formatting
    echo "Extracting text from $pdf_file..."
    pdftotext -layout -enc UTF-8 "$pdf_file" "$temp_file"

    # Check if pdftotext produced any output
    if [ ! -s "$temp_file" ]; then
        echo "Warning: No text extracted from $pdf_file. It may contain images or unsupported fonts."
        cp "$temp_file" "$output_folder/raw_text.txt"
        rm -rf "$temp_dir"
        continue
    fi

    # Save a copy of raw text for debugging
    cp "$temp_file" "$output_folder/raw_text.txt"
    echo "Saved raw text to $output_folder/raw_text.txt for inspection"
    line_count=$(wc -l < "$temp_file" | awk '{print $1}')
    echo "Raw text size: $line_count lines"

    # Estimate lines per page
    if [ "$page_count" -gt 0 ]; then
        lines_per_page=$(( (line_count + page_count - 1) / page_count ))
        echo "Estimated $lines_per_page lines per page"
    else
        lines_per_page=$line_count
        page_count=1
        echo "Assuming single page with $lines_per_page lines"
    fi

    # Split the text into pages based on estimated lines per page
    echo "Splitting text into pages for $pdf_file..."
    cd "$temp_dir" || exit 1
    split -l "$lines_per_page" -d "$temp_file" page --additional-suffix=.txt
    page_num=1
    for txt_file in page*; do
        if [ -f "$txt_file" ] && [ -s "$txt_file" ]; then
            mv "$txt_file" "$output_folder/$page_num.txt"
            echo "Created $output_folder/$page_num.txt"
            ((page_num++))
        else
            rm -f "$txt_file"
        fi
    done

    # Fallback: If no pages were created, save raw text as 1.txt
    if [ "$page_num" -eq 1 ] && [ -s "$temp_file" ]; then
        echo "Warning: No pages split. Saving raw text as 1.txt..."
        mv "$temp_file" "$output_folder/1.txt" && echo "Created $output_folder/1.txt"
    fi

    # Clean up temporary directory
    rm -rf "$temp_dir"

    echo "Processed $pdf_file -> $output_folder"
done

echo "Conversion complete!"