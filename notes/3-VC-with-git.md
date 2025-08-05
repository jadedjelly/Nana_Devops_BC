Handouts:
* ![checklist](assets/files/03_Git_Checklist.pdf)
* ![handout](assets/files/03_Git_Handout.pdf)

# setting up local git configs

* Create local ssh keys

```console
ssh-keygen -t ed25519 -C [email address]
```

* copy the .pub contents to (from github), Settings > SSH and GPG keys
* give it a name, I usually name it by the computer name


# Git flow of setting up a new repo from scratch

1. create a local dir

```bash
mkdir my-project
cd my-project
```

2. (Init)ialize git

```bash
git init
# creates a .git folder
```

3. Add some files (if not already present)

```bash
echo "#my project" > README.md
```

4. Stage files

```bash
git add .
# using the . adds all files in the directory, if you wanted to only stage a single file, you would input the filename
```

5. Commit the files

```bash
git commit -m "initial commit"
```

6. Create a remote repo
- Go to GitHub/GitLab/Bitbucket and create a new repository. Don’t initialize it with a README or .gitignore—you're pushing a full repo.

7. Add the remote URL

```bash
git remote add origin https://github.com/your-username/your-repo.git
```

8. Push to remote
_Make sure your branch name matches the default (usually main or master):_
```bash
git branch -M main    # Rename to 'main' if needed
git push -u origin main
```

9. Final check

```bash
git remote -v
```

* you should see:

origin  https://github.com/your-username/your-repo.git (fetch)
origin  https://github.com/your-username/your-repo.git (push)

# Cloning a git repo

1. Copy the Repository URL

From GitHub/GitLab/Bitbucket, copy either:
* HTTPS: https://github.com/user/repo.git
* SSH: git@github.com:user/repo.git

2. Clone the Repository

```bash
git clone https://github.com/user/my-project.git
```

this does the following:
This:

* Downloads all files
* Creates a local .git/ folder
* Sets up origin as the default remote

3. Navigate into the Project

```bash
cd my-project
```

4. Check the Remote (optional)

```bash
git remote -v
```
* you should see:
origin  https://github.com/user/my-project.git (fetch)
origin  https://github.com/user/my-project.git (push)

5. Start Working

* Modify files
* Stage with git add
* Commit with git commit
* Push with git push

# Commands

* git clone (create local copy of remote repo)
* git add
* git commit
* git log
* git push
* git pull
* git init
* git remote add origin [remote_repo]
* git push - -set-upstream origin master (create local git repo and connect to remote repo)
* git checkout [branch]
* git checkout -b [branch](create new branch locally)
* git branch
* git status
* git branch -d [branch]
* git rebase(avoid unnecessary merge commits in git history)
* git rm -r - -cached [folder]
* git rm - -cached [file] (remove file from remote repo)
* git stash
* git stash pop(save unfinished changes)
* git reset - -hard HEAD~1(revert & discard changes to commit, ~[number commits to revert])
* git reset HEAD~1(revert & keep changes)
* git commit - -amend(merge changes into last commit)
* git reset - -hard HEAD~1
* git push - -force
* git revert [commit_hash](creates new commit to revert old commit changes)
* git merge

# Remove Git

remove local .git file (contains config for git remotes etc)
rm -fr .git

# best practices

1 branch per feature
dev branch: intermediary master branch
pull/merge requests
delete branch when merged
add .gitignore file
