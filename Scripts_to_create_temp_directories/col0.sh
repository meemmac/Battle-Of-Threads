#!/bin/bash

BASE="$HOME/Desktop/battle_test"
DIR1="$BASE/organizer_dir/"
DIR2="$BASE/junk_dir/"
DIR3="$BASE/cleaner_dir/"

# Reset old data
rm -rf "$BASE"
mkdir -p "$DIR1" "$DIR2" "$DIR3"

echo "📂 Created test directories:"
echo " - Organizer: $DIR1"
echo " - Cleaner: $DIR3"
echo " - Junk: $DIR2"


# -----------------------
# Organizer directory: normal files + duplicates + mixed extensions
echo "Organizer normal file" > "$DIR1/file1.txt"
echo "Another organizer file" > "$DIR1/file2.txt"
echo "Duplicate content" > "$DIR1/dup1.txt"
cp "$DIR1/dup1.txt" "$DIR1/dup2.txt"
echo "Python code" > "$DIR1/script.py"
echo "Bash script" > "$DIR1/script.sh"

# -----------------------
# Cleaner directory: empty files + duplicates to test Phoenixes
> "$DIR3/empty1.txt"
> "$DIR3/empty2.tmp"
echo "Duplicate for cleaner" > "$DIR3/dup1.txt"
cp "$DIR3/dup1.txt" "$DIR3/dup2.txt"
echo "Another unique file" > "$DIR3/unique.txt"

# -----------------------
# Junk directory: junk files only
echo "Temporary junk" > "$DIR2/junk1.tmp"
echo "Swap junk" > "$DIR2/junk2.swp"
echo "Cookie junk" > "$DIR2/junk3.cookie"
echo "Log file" > "$DIR2/log1.log"
echo "Old backup" > "$DIR2/old.bak"
echo "Core dump" > "$DIR2/core1.core"

