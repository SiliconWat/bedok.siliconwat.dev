#!/bin/bash

# Configuration
FOLDER_PATH="./test" # Directory with PDFs
OUTPUT_DIR="./json" # Directory for JSON output

# Check for required tools
if ! command -v pdftotext &> /dev/null; then
    echo "Error: pdftotext not found. Please install poppler-utils."
    exit 1
fi
if ! command -v jq &> /dev/null; then
    echo "Error: jq not found. Please install jq."
    exit 1
fi

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Process each PDF
for pdf_file in "$FOLDER_PATH"/*.pdf; do
    if [[ -f "$pdf_file" ]]; then
        echo "Processing: $pdf_file"
        base_name=$(basename "$pdf_file" .pdf)
        text_file="$OUTPUT_DIR/$base_name.txt"
        json_file="$OUTPUT_DIR/$base_name.json"

        # Extract text
        pdftotext "$pdf_file" "$text_file"

        # Check extraction
        if [[ -s "$text_file" ]]; then
            echo "Text extracted for $base_name"
            text_content=$(cat "$text_file" | jq -R -s .)
            jq -n --arg fname "$base_name" --arg text "$text_content" \
                '{ "filename": $fname, "text": $text }' > "$json_file"
            if [[ $? -eq 0 ]]; then
                echo "Created JSON: $json_file"
                rm "$text_file"
            else
                echo "Failed to create JSON for $base_name"
            fi
        else
            echo "Text extraction failed or empty for $base_name"
            rm -f "$text_file"
        fi
    fi
done

echo "Processing complete."