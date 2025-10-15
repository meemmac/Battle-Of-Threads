#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
ITALIC='\033[3m'
RESET='\033[0m'
time=0.5

show_rules() {
    echo -e "\nBefore we begin, here are the rules: 📜\n"
    tput setaf 3  
    echo -e "🔥 **Player 1 - The Organizer** 🔥"
    echo -e "Strength: Organizing files by extension.\nWeakness: Less manpower, unable to handle too many files at once.\nThe Organizer cannot be deleted but may have fewer resources to deal with files efficiently."

    tput setaf 2
    echo -e "\n⚡ **Player 2 - The Junk Deletor** ⚡"
    echo -e "Strength: Unmatched power to delete junk files (e.g., .tmp, .swp, .cookie).\nWeakness: Their actions cannot be stored, so once done, they are gone forever.\nThe Junk Deletor is undefeatable and always operates at full power!"

    tput setaf 4
    echo -e "\n💨 **Player 3 - The Cleaner** 💨"
    echo -e "Strength: Can clean large amounts of space effectively.\nWeakness: Can be revived from 'Lost Soldiers' folder if deleted, making them a persistent threat.\nThe Cleaner has the power to reclaim lost space, but their persistence is their double-edged sword!"

    tput setaf 5
    echo -e "\n**Important Notes**: 📋"
    echo -e "If a player does not wish to participate, simply press **-** and hit **Enter**."
    echo -e "Scoring criteria: organizing and deletion increases score as +size of file. Cleaning makes number of +files*15."
    echo -e "Once the battle begins, you can no longer change your choice."
    tput sgr0 
    echo -n "⚔️Battle Loading⚔️..."
    for (( j=0 ; j<100; j++ )); do
        sleep 0.08
        echo -n "."
    done
    echo -e "\n"
}

organize_files() {
    dir="$1"
    if [[ ! -d "$dir" ]]; then
        echo "It was all a lie!-Organizer: +0"
        sleep $time
        return
    fi
    total=0
    for f in "$dir"/*; do
        if [[ ! -f "$f" ]]; then
            continue
        fi
        ext="${f##*.}"
        if [[ -z "$ext" ]]; then
            ext="no_ext"
        fi
        mkdir -p "$dir/$ext"
        size=$(stat -c%s "$f" 2>/dev/null)
        mv "$f" "$dir/$ext/" 2>/dev/null
        echo -e "Warrior Sir Organizer: ${YELLOW}$(basename "$f")${RESET} +$size"
        sleep $time
        total=$((total + size))
    done
    if [[ $total -eq 0 ]]; then
        echo "Where are you sir organizer?: +0"
        sleep $time
    fi
}

delete_junks() {
    dir=$1
    if [[ ! -d "$dir" ]]; then
        echo "Oh no! Where am I??-Junk: +0"
        sleep $time
        return
    fi
    total=0
    lost_soldiers="$dir/Lost_Soldiers"
    mkdir -p "$lost_soldiers"
    patterns=("*.tmp" "*.log" "*.bak" "*.cache" "*.swp" "*.old" "*.dmp" "*.cookie" "*.temp" "*.core" "*.o" "*.a")

    touch "$dir/junk_file.txt"
    ls "$dir" > "$dir/junk_file.txt"
    n=$(wc -l < "$dir/junk_file.txt")

    i=1
    while [ $i -le $n ]; do
        file=$(sed -n "${i}p" "$dir/junk_file.txt")
        filepath="$dir/$file"
        if [ -f "$filepath" ]; then
            matched=false
            for pat in "${patterns[@]}"; do
                if [[ "$file" == $pat ]]; then
                    size=$(stat -c%s "$filepath" 2>/dev/null )
                    echo -e "Marshal Junk: ${GREEN}$(basename "$file")${RESET} +$size"
                    sleep $time
                    total=$((total + size))
                    mv "$filepath" "$lost_soldiers" 2>/dev/null
                    matched=true
                    break
                fi
            done
        fi
        i=$((i+1))
    done

    rm -r "$dir/junk_file.txt" 2>/dev/null
    if [[ $total -eq 0 ]]; then
        echo "Nobody could fight on behalf of Junks :( +0"
        sleep $time
    fi
}
safe_clean() {
    directory="$1"
    phoenix_folder="$directory/Phoenixes"

    mkdir -p "$phoenix_folder"
    count=0
    declare -A seen

    for file in "$directory"/*; do
        if [ ! -f "$file" ]; then
    continue
     fi
  
        if [ ! -e "$file" ]; then
    continue
    fi
  

        if [ ! -s "$file" ]; then
            echo -e "Spectacular Cleaner: ${BLUE}$(basename "$file")${RESET} +15"
            mv "$file" "$phoenix_folder/" 2>/dev/null
            count=$((count + 1))
            sleep $time
        else
            checksum=$(md5sum "$file" 2>/dev/null | awk '{print $1}') 
            if [ -z "$checksum" ]; then
                continue
            fi
            if [[ -n "${seen[$checksum]}" ]]; then
                echo -e "Spectacular Cleaner: ${BLUE}$(basename "$file")${RESET} +15"
                mv "$file" "$phoenix_folder/" 2>/dev/null
                count=$((count + 1))
                sleep $time
            else
                seen[$checksum]=1
            fi
        fi
    done

    total=$((count * 15))
    if [[ $total -eq 0 ]]; then
        echo "Cleaner: +0 because there is no one :("
        sleep $time
    fi
}


if [ "$1" == "organize_files" ]; then
    organize_files "$2"
    exit 0
elif [ "$1" == "delete_junks" ]; then
    delete_junks "$2"
    exit 0
elif [ "$1" == "safe_clean" ]; then
    safe_clean "$2"
    exit 0
fi

multithreading_battle() {
    gcc -pthread battle.c -o battle
    ./battle "$1" "$2" "$3"
}

echo -e "${CYAN}\n🎉 Welcome to the ${RESET}"
if command -v figlet &> /dev/null; then
    figlet -f slant "Battle of Threads!"
else
    echo -e "${CYAN}${BOLD}Battle of Threads! ⚔️${RESET}"
fi
echo -e "${YELLOW}Get ready to embark on an epic journey of organizing, cleaning, and battling! 🎮${RESET}"
echo -e "Do you want to see the rules?Type(y/n)"
read rule_confirmation
if [[ "$rule_confirmation" == "y" || "$rule_confirmation" == "Y" ]]; then  
    show_rules
fi
echo -e "${CYAN}Ready to start the battle? 👀${RESET}"
echo -e "${MAGENTA}Please choose the warriors! ⚔️${RESET}"

echo -e "${RED}Player one: enter the directory you want to organize 📚${RESET}"
read dir1
echo -e "${GREEN}Player two: enter the directory you want to clean 🧹${RESET}"
read dir3
echo -e "${BLUE}Player three: activate the ultimate monster in your given directory! Junk file deletor 🗑${RESET}"
read dir2

multithreading_battle "$dir1" "$dir2" "$dir3"

echo -e "${RED}"  # color works
figlet "Keep your friends close,"
sleep 2
figlet "your enemies closer"
echo -e "${RESET}"

echo "The battle ended."
sleep 1
echo "Winner is annouced.But can you find out which warriors were disloyal?"
sleep 1
echo "They are where they were not supposed tobe..."
sleep 1
