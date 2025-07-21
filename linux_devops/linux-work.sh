#!/bin/bash

# ----------------------------------------
# Linux Commands for DevOps Beginners
# ----------------------------------------

# === File System Navigation ===

# Print Working Directory
pwd

# List files and directories
ls
ls -l       # Long listing format
ls -a       # Show hidden files

# Print system info
uname
uname -r    # Kernel release

# Change directory
cd ~

# Clear terminal screen
clear

# Show current logged-in user
whoami

# Show command history
history

# === Memory and DNS ===

# Check memory usage
free -h

# DNS lookup
nslookup google.com

# === SSH & Networking ===

# Generate SSH key pair
ssh-keygen -t rsa

# Show network interfaces (old and new)
ifconfig
ip a 

# === Curl (Web Requests) ===

# Basic usage
curl https://example.com

# Save output to a file
curl -o saved_file.html https://example.com

# === Package Management ===

# Update and install packages (Debian-based)
sudo apt-get update
sudo apt-get install htop

# === Disk Usage ===

# Show disk usage
du -sh *

# Show available disk space
df -h

# === Creating Directories ===

mkdir MyFolder                     # Single directory
mkdir Folder1 Folder2 Folder3     # Multiple directories
mkdir -p /tmp/My/DevOps/Project   # Nested directories
mkdir myDir{1..3}                    # Series of numbered dirs

# === Creating Files ===

touch file1.txt file2.txt                 # Empty files
echo "Hello DevOps" > hello.txt          # With content
cat > notes.txt                          # Type then Ctrl+D
# nano file.txt
# vi file.txt

# === File Operations ===

cp -rvf file1.txt backup_file1.txt       # Copy file
rm -rvf Folder3                          # Remove directory
mv oldname.txt newname.txt               # Rename file

# rm -rf and rm -rvf perform the same operation—both delete files and directories recursively and forcefully. The difference is that -v (verbose) in rm -rvf provides visual feedback by showing each file and directory being deleted

# === User Management ===

sudo useradd newuser
sudo passwd newuser
sudo userdel newuser
su newuser
sudo usermod -l newname oldname          # Rename user

# === Group Management ===

sudo groupadd devops
sudo groupdel devops
sudo usermod -g devops newuser           # Add user to group

# === Process Management ===

ps aux                                   # List processes
top                                      # Real-time monitor
kill 1234                                # Kill by PID
pidof bash                               # Get PID of process
sudo systemctl status ssh               # Check service status

# === Permissions & Ownership ===

ls -ld .                                 # Check dir permissions
chmod 755 script.sh                      # Change file mode
chown $USER:$USER script.sh              # Change owner

# === Viewing File Content ===

cat -b script.sh                         # Numbered lines
cat -E script.sh                         # End of line markers

# === Searching with Grep ===

grep "hello" hello.txt
grep -i "hello" hello.txt                # Case insensitive
grep -n "hello" hello.txt                # Show line numbers
grep -v "hello" hello.txt                # Exclude matches

# === Sorting ===

sort hello.txt

# === Display Top/Bottom of Files ===

head -n 2 hello.txt
tail -n 3 hello.txt

# === Finding Files ===

find . -name "*.txt"

# === File Metadata === --  The stat command is used to display detailed permission and ownership metadata.

stat hello.txt