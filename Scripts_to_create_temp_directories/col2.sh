#!/bin/bash

BASE="$HOME/Desktop/battle_test"
MERGED="$BASE/Merged_Org_Clean"
JUNK="$BASE/Junk"

# Remove old data
rm -rf "$BASE"
mkdir -p "$MERGED" "$JUNK"

echo "📂 Created test directories:"
echo "   - Merged(Organizer + Cleaner): $MERGED/ "
echo "   - Junk: $JUNK/"

# -----------------------
# Merged directory (Organizer + Cleaner)
# Normal files
echo "normal file 1" > "$MERGED/file1.txt"
echo "normal file 2" > "$MERGED/file2.md"
# Duplicate files
echo "duplicate content" > "$MERGED/dup1.txt"
cp "$MERGED/dup1.txt" "$MERGED/dup2.txt"
# Empty files
> "$MERGED/empty1.txt"
> "$MERGED/empty2.py"
# Additional duplicates for testing Cleaner
echo "duplicate again" > "$MERGED/dup3.txt"
cp "$MERGED/dup3.txt" "$MERGED/dup4.txt"
# Unique Python/Bash files
echo "python script" > "$MERGED/script1.py"
echo "bash script" > "$MERGED/script2.sh"

# -----------------------
# Junk directory
echo "junk temp" > "$JUNK/junk1.tmp"
echo "swap file" > "$JUNK/junk2.swp"
echo "cookie junk" > "$JUNK/junk3.cookie"
echo "log file" > "$JUNK/log1.log"
echo "old backup" > "$JUNK/old.bak"

