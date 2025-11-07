#!/usr/bin/env python3
"""
Pre-process markdown to convert mermaid code blocks to PNG images.
"""
import re
import subprocess
import os
import hashlib
import sys

def extract_mermaid_blocks(markdown_content):
    """Extract all mermaid code blocks from markdown."""
    pattern = r'```mermaid\n(.*?)\n```'
    matches = re.finditer(pattern, markdown_content, re.DOTALL)
    
    blocks = []
    for match in matches:
        blocks.append({
            'full_match': match.group(0),
            'code': match.group(1),
            'start': match.start(),
            'end': match.end()
        })
    return blocks

def generate_image_filename(mermaid_code):
    """Generate a unique filename based on the mermaid code."""
    hash_obj = hashlib.md5(mermaid_code.encode())
    return f"mermaid_{hash_obj.hexdigest()[:12]}.png"

def render_mermaid(mermaid_code, output_path):
    """Render mermaid code to PNG using mmdc."""
    # Create temporary mermaid file
    temp_mmd = 'temp_diagram.mmd'
    with open(temp_mmd, 'w') as f:
        f.write(mermaid_code)
    
    try:
        # Run mmdc to generate PNG
        subprocess.run([
            'mmdc',
            '-i', temp_mmd,
            '-o', output_path,
            '-b', 'transparent',
            '-w', '800'  # width in pixels
        ], check=True, capture_output=True, text=True)
        
        print(f"✅ Generated: {output_path}")
        return True
    except subprocess.CalledProcessError as e:
        print(f"❌ Failed to render mermaid: {e.stderr}")
        return False
    finally:
        # Cleanup temp file
        if os.path.exists(temp_mmd):
            os.remove(temp_mmd)

def process_markdown(input_file, output_file, images_dir='mermaid-images'):
    """Process markdown file and convert mermaid blocks to images."""
    # Create images directory if it doesn't exist
    os.makedirs(images_dir, exist_ok=True)
    
    # Read input markdown
    with open(input_file, 'r') as f:
        content = f.read()
    
    # Extract mermaid blocks
    blocks = extract_mermaid_blocks(content)
    
    if not blocks:
        print("ℹ️  No mermaid blocks found")
        # Just copy the file as-is
        with open(output_file, 'w') as f:
            f.write(content)
        return
    
    print(f"Found {len(blocks)} mermaid diagram(s)")
    
    # Process in reverse order to maintain string positions
    for block in reversed(blocks):
        # Generate image filename
        img_filename = generate_image_filename(block['code'])
        img_path = os.path.join(images_dir, img_filename)
        
        # Render mermaid to PNG
        if render_mermaid(block['code'], img_path):
            # Replace mermaid block with image reference
            # Using LaTeX-friendly syntax for better PDF rendering
            replacement = f"\n![Diagram]({img_path}){{ width=80% }}\n"
            
            content = (
                content[:block['start']] + 
                replacement + 
                content[block['end']:]
            )
    
    # Write processed markdown
    with open(output_file, 'w') as f:
        f.write(content)
    
    print(f"\n✅ Processed markdown saved to: {output_file}")

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Usage: process_mermaid.py <input.md> <output.md>")
        sys.exit(1)
    
    input_file = sys.argv[1]
    output_file = sys.argv[2]
    
    if not os.path.exists(input_file):
        print(f"Error: Input file not found: {input_file}")
        sys.exit(1)
    
    process_markdown(input_file, output_file)
