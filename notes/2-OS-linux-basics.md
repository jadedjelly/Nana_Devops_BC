# Linux basics

Handouts:
* ![checklist](assets/files/02_Linux_Checklist.pdf)
* ![handout](assets/files/02_Linux_Handout.pdf)

## VMs:

- Need a hypervisor compatiable CPU, to run VMs, most pop is VBOX, I prefer Vmware Workstation pro (snapshots)
- 2x types, Type 1 & type 2
    - Type 1: efficent suage of host resources
    - Type 2: test & play, good for testing apps on different OSs

## Linux File System

- Everything is a file
- Hidden files start with a .(dot)

* /home/{Username} dir: of non-root users (If the user is created with a home directory)
* /bin: executables for essential system cmd
* /sbin: Sudo system binaries
* /lib: shared lib that execs from /bin or /sbin use
* /usr: was used for user home dir (histroic reasons due to storage limitations)
* /usr/local: programs that YOU install on computer (3rd party apps) available for all users
* /opt: 3rd party programs you install that DONT split its components
* /boot: files required for booting
* /etc: system config
* /dev: device files (webcam, mouse, keyboard etc)
* /var: stores logs
* /var/cache:
* /tmp: temporary resources required for processes
* /media: removable media
* /mnt: temporary mount points

## Common linux commands:

* pwd = show current dir
* ls = list contents
* cd = change dir (cd / = change to root dir and empty cd is go to home)
* mkdir = make dir
* touch = create file
* rm = delete file
* rm -r = delete non-empty dir with files in it
* rmdir = delete empty dir
* clear = clears terminal
* mv <old-name> <new-name> = rename file to new name
* cp -r <dir> <new-dir> = copy contents folder to new folder
* ls -R = list all folders and files in each
* history = lists all recent cmd in terminal
* ls -a = display hidden files
* ls -l = print files in long list format (ls -la for listing hidden files)
* cat = show contents file
* uname -a = show system & kernel
* cat /etc/os-release = show release version
* lscpu = cpu info
* lsmem = memory info
* sudo = grants super user privileges for cmd
* su - [username] = become user
* | = pipe, passes output of one cmd as input of next cmd
* <input> | less = displays reader friendly format for info in CLI
* <input> | grep <pattern> = filter input based on pattern search
*  (>) = redirect, takes output from previous cmd and sends it to file that you give (overrides contents file)
* (> >) = appends text to end of file
* (> >) Can pass multiple cmd in one line separated by ;

## Installing s/w, w/ Package manager APT

- Downloads, installs, removes
- can pass sha easily

```bash

apt search <package name>
apt install <package name>
apt remove <package name>
apt update
apt upgrade
apt autoremove
apt full-upgrade


```
03.Bonus - Databases Handout.pdf

## VIM your besr friend for editing files

* :wq = quit and save
* :q! = quit without saving
* dd = delete line
* d10d = delete next 10 lines
* u = undo
* A = jump to end of line, switch insert mode
* $ = jump to end line, without switch insert mode
* 0 = jump to beginning of line
* 12G = jump to line 12
* /pattern = search for pattern
* n = jump to next match
* N = jump to previous match
* :%s/old/new = replace old with new throughout file

## Users, Groups & Permissions

3 user categories:

* Root user
* Regular user
* Service user (best practice for security) (no login shell) These users can be used for nexus or docker as an example

Can group users and define group permissions
Users can have multiple groups

## Commands

* adduser [username]
* passwd [username]
* su - [username]
* su - switch root user
* sudo bash does the same as above
* groupadd [groupname]
* deluser [username]
* groupdel [groupname]
* usermod [OPTIONS] [username]
* usermod -g [groupname] [username]
* usermod -G [groupname] [username] (overrides secondary groups list)
* usermod -aG [groupname] [username] (appends to existing list)
* gpasswd -d [username] [groupname]
* groups [username] (lists users groups)
* exit (logout user)
* chown [username]:[groupname] [filename] (change file ownership)
* chgrp [groupname] [filename]

## Permissions

_NOTE:_ Octal permissions, 4 = read, 2 = write, 1 = execute


(owner)

* r = read
* w = write
* x = execute
* -= No permission

(group)

* r = read
* w = write
* x = execute
* -= No permission

(other)

* r = read
* w = write
* x = execute
* -= No permission

## Chmod
* chmod -x [filename] (remove execute permissions for all owners)
* chmod g-w [filename] (remove write permissions for group)
* chmod g+x [filename] (add execute permissions for group)
* chmod u+x [filename] (add execute permission for user)
* chmod o+x [filename] (add execute permission for others)
* chmod g=rwx [filename] (sets specific block permissions for group)
* chmod 777 [filename] (gives all permission to all owners)

__NOTE:__ Prefer using chmod g+x etc than octal

_NOTE to self:_ More linux commands are in the RHCSA notes