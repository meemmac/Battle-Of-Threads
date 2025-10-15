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
```
You can execute scripts to create temporary directory with proper collision factors

```bash
chmod +x col3.sh
./col3.sh
```
and then

```bash
chmod +x battle.sh
./battle.sh /path/to/directory_given_by_col3.sh
```

## Preview:

- Starting the script

<img width="800" height="400" alt="VirtualBox_kali-linux-2025 2-virtualbox-amd64_23_09_2025_21_12_11" src="https://github.com/user-attachments/assets/04559fb5-e7db-47c4-9b1c-851e59f9d607" />

- Rules
  
<img width="800" height="400" alt="VirtualBox_kali-linux-2025 2-virtualbox-amd64_23_09_2025_21_25_13" src="https://github.com/user-attachments/assets/c4b125a8-d323-4a41-a58c-dce3d981a3a2" />

- Process(battle) execution
  
<img width="800" height="400" alt="VirtualBox_kali-linux-2025 2-virtualbox-amd64_23_09_2025_21_19_18" src="https://github.com/user-attachments/assets/57d74ed0-1af9-47be-9b33-358c0defe626" />

- Summary of the execution

<img width="800" height="400" alt="VirtualBox_kali-linux-2025 2-virtualbox-amd64_23_09_2025_21_19_54" src="https://github.com/user-attachments/assets/a8885a20-c537-437e-8d15-62bc7181c358" />




