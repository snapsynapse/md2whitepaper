#!/usr/bin/env bash
#
# Whitepaper Generator Build Script
# 
# This script converts Markdown files to professional PDF whitepapers.
# It handles mermaid diagrams, custom LaTeX templates, and automated cleanup.
#
# Usage:
#   ./build_whitepaper.sh                           # Uses defaults
#   INPUT_MD="doc.md" ./build_whitepaper.sh         # Custom input
#   OUTPUT_PDF="report.pdf" ./build_whitepaper.sh   # Custom output
#
# Requirements:
#   - pandoc (markdown to LaTeX conversion)
#   - pdflatex (LaTeX to PDF compilation)
#   - python3 (mermaid pre-processing)
#   - mmdc (mermaid diagram rendering)
#
# Author: PAICE.work PBC
# License: MIT
# Version: 2.0
#

# Exit on error, undefined variables, and pipe failures
set -euo pipefail

#==============================================================================
# Configuration
#==============================================================================

# Resolve the directory this script lives in (works no matter where you run it)
SCRIPT_DIR="$(cd -- "$(dirname -- "$0")" >/dev/null 2>&1 && pwd -P)"

# Filenames - can be overridden via environment variables
INPUT_MD="${INPUT_MD:-PAICE_work_Overview.md}"
TEMPLATE_TEX="${TEMPLATE_TEX:-whitepaper_template.tex}"
OUTPUT_PDF="${OUTPUT_PDF:-PAICE_work_Overview.pdf}"

# Construct absolute paths
INPUT_PATH="${SCRIPT_DIR}/${INPUT_MD}"
TEMPLATE_PATH="${SCRIPT_DIR}/${TEMPLATE_TEX}"
OUTPUT_PATH="${SCRIPT_DIR}/${OUTPUT_PDF}"

#==============================================================================
# Startup Banner
#==============================================================================

echo "========================================"
echo "Whitepaper Generator v2.0"
echo "========================================"
echo
echo "Input:    ${INPUT_PATH}"
echo "Template: ${TEMPLATE_PATH}"
echo "Output:   ${OUTPUT_PATH}"
echo

#==============================================================================
# Validation
#==============================================================================

# Verify required files exist
if [[ ! -f "${INPUT_PATH}" ]]; then
    echo "❌ ERROR: Input file not found: ${INPUT_PATH}"
    exit 1
fi

if [[ ! -f "${TEMPLATE_PATH}" ]]; then
    echo "❌ ERROR: Template not found: ${TEMPLATE_PATH}"
    exit 1
fi

# Check if mermaid pre-processor exists
if [[ ! -f "${SCRIPT_DIR}/process_mermaid.py" ]]; then
    echo "❌ ERROR: process_mermaid.py not found in ${SCRIPT_DIR}"
    echo "Please ensure process_mermaid.py is in the same directory as this script."
    exit 1
fi

# Verify required commands are available
for cmd in python3 pandoc pdflatex mmdc; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "❌ ERROR: Required command not found: $cmd"
        echo "Please install $cmd and try again."
        exit 1
    fi
done

#==============================================================================
# Build Pipeline
#==============================================================================

# Change to script directory for relative path resolution
cd "${SCRIPT_DIR}"

#------------------------------------------------------------------------------
# Step 1: Pre-process Mermaid Diagrams
#------------------------------------------------------------------------------
# Extracts mermaid code blocks, renders them as PNG images, and replaces
# them with standard markdown image references. This avoids pandoc filter
# issues and produces high-quality diagram images.

echo "Step 1: Pre-processing mermaid diagrams..."
python3 "${SCRIPT_DIR}/process_mermaid.py" "${INPUT_MD}" "${INPUT_MD%.md}_processed.md"
echo

#------------------------------------------------------------------------------
# Step 2: Convert Markdown to LaTeX
#------------------------------------------------------------------------------
# Uses pandoc with custom template to convert processed markdown to LaTeX.
# The template handles all formatting, colors, and layout customization
# based on YAML frontmatter in the markdown file.

echo "Step 2: Converting markdown to LaTeX..."
pandoc "${INPUT_MD%.md}_processed.md" \
    --from markdown \
    --to latex \
    --template="${TEMPLATE_TEX}" \
    --variable geometry:margin=1in \
    --table-of-contents \
    --toc-depth=2 \
    --number-sections \
    -o "${INPUT_MD%.md}.tex"

#------------------------------------------------------------------------------
# Step 3: Compile LaTeX to PDF
#------------------------------------------------------------------------------
# Runs pdflatex twice:
# - First pass: Generate document and TOC data
# - Second pass: Resolve TOC page numbers and cross-references
# Errors are suppressed for cleaner output (logged to .log file)

echo "Step 3: Compiling LaTeX to PDF..."
pdflatex -interaction=nonstopmode "${INPUT_MD%.md}.tex" > /dev/null
pdflatex -interaction=nonstopmode "${INPUT_MD%.md}.tex" > /dev/null

#------------------------------------------------------------------------------
# Step 4: Finalize Output
#------------------------------------------------------------------------------

# Move the PDF to final output name if needed
if [[ "${INPUT_MD%.md}.pdf" != "${OUTPUT_PDF}" ]]; then
    mv "${INPUT_MD%.md}.pdf" "${OUTPUT_PDF}"
fi

#==============================================================================
# Success Message
#==============================================================================

echo
echo "========================================"
echo "✅ Success! PDF created:"
echo "   ${OUTPUT_PATH}"
echo "========================================"

#==============================================================================
# Cleanup
#==============================================================================
# Remove auxiliary LaTeX files and temporary processed markdown
# Keep: Original markdown, final PDF, generated images

rm -f *.aux *.log *.out *.toc "${INPUT_MD%.md}.tex" "${INPUT_MD%.md}_processed.md"

echo
echo "Cleaned up temporary files."
echo

#==============================================================================
# End of Script
#==============================================================================
