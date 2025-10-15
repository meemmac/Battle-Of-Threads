#!/bin/bash
# Sample collision test generator for battle

BASE="$HOME/Desktop/battle_test"
COLLISION="$BASE/collision_dir"

# Reset old data
rm -rf "$BASE"
mkdir -p "$COLLISION"

echo "📂 Created collision directory at $COLLISION/"

# -------------------------
# Empty files
touch "$COLLISION/empty1.txt"
touch "$COLLISION/empty2.tmp"
touch "$COLLISION/empty3.py"

# -------------------------
# Duplicate files
echo "duplicate content" > "$COLLISION/dup1.txt"
cp "$COLLISION/dup1.txt" "$COLLISION/dup2.txt"         # duplicate same extension
echo "duplicate content" > "$COLLISION/dup3.py"
cp "$COLLISION/dup3.py" "$COLLISION/dup4.py"           # duplicate same extension
cp "$COLLISION/dup1.txt" "$COLLISION/dup5.txt"         # another duplicate

# -------------------------
# Mixed correct files
echo "normal txt file" > "$COLLISION/file1.txt"
echo "another txt file" > "$COLLISION/file2.txt"
echo "python code" > "$COLLISION/script1.py"
echo "bash script" > "$COLLISION/script2.sh"
echo "markdown file" > "$COLLISION/readme.md"

# -------------------------
# Junk files
echo "temp junk" > "$COLLISION/junk1.tmp"
echo "swap junk" > "$COLLISION/junk2.swp"
echo "cookie junk" > "$COLLISION/junk3.cookie"

# -------------------------
# Same extension with empty + duplicate
echo -n "" > "$COLLISION/empty_dup.txt"
echo "duplicate again" > "$COLLISION/dup6.txt"
cp "$COLLISION/dup6.txt" "$COLLISION/dup7.txt"

# -------------------------
# Unique files with different extensions
echo "log file" > "$COLLISION/log1.log"
echo "config file" > "$COLLISION/config.cfg"
echo "image placeholder" > "$COLLISION/image.jpg"

