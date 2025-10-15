# Battle-Of-Threads

**Battle-Of-Threads** is a fun Linux shell tool that organizes files, deletes duplicates and junk files, and does it all using multi-threading — like a battle between file-cleaning warriors!

---

## What It Does

- Organizes files into folders
- Deletes duplicate and empty files
- Deletes junk files (like `.tmp`)
- Runs everything together in a "battle" using threads

---

## Clans (Processes)

Each type of task is handled by a different clan:

- **Spectacular Cleaner** → Deletes junk files  
- **Sir Organizer** → Organizes files  
- **Marshal Junk** → Deletes duplicate and empty files  

Each script is a "warrior" in its clan.

---

## How Scoring Works

- **Non-empty files**: Add up their sizes (in bytes)
- **Empty or duplicate files**: `15 points × number of files`

---

## Battle Arena

- You give one or more folders (directories) to clean.
- All clans run at the same time using multi-threading.
- You can give the **same folder to multiple clans** — but this may cause **betrayal**.

---

## Betrayal

Sometimes, a clan does work that belongs to another:

- Example: A `.tmp` file gets organized instead of deleted.
- These are called **betrayers**.
- The tool shows these betrayals during the run.

---

## Stealth Mode

- Error messages (like "directory not found") are hidden using `2>/dev/null`
- This helps simulate surprise attacks and "stealing kills"

---

## How to Use

```bash
chmod +x battle.sh
./battle.sh /path/to/folder1 /path/to/folder2 ...
