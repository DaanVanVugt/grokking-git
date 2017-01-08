class: center, middle
# Version control with Git
*January 2017*

Daan van Vugt<sup>1</sup>, Guido Huijsmans

.footnote[<sup>1</sup> <daanvanvugt@gmail.com>]

---

# What is version control?
.xx-large[
* Track files over time
* Go back to working versions when you make a mistake
* You have probably used a basic version yourself:
  * Files like `report4.tex`, `plot_q.old.m` etc.
  * Google drive, Dropbox
]
---
# Properties of a _proper_ version control system
.xx-large[
* Backup and restore
* Synchronization
* Short-term undo
* Long-term undo
* Track changes
* Track ownership
* Sandboxing / branches
]

---

# What is Git?
.xx-large[
* Git is a content tracker
* It is a collection of tools implementing
  * (Directory) tree history storage
  * Operations on this history
  * Synchronization
* This allows it to function as a version control system!
]

---

# Outline
## The design of Git
## Basic commands
## Parallel histories: branching and merging
## Examples and use cases
## Advanced stuff

---
class: center, middle
# The design of Git
---
# Commits (snapshot of the project in time)
.xx-large[
* Versions are managed in git as _snapshots_ of your files
* These are called __commits__
* You make these manually
  * When some small feature is 'finished'
  * With a message describing the changes
]

--

## We will draw them like this:
![A commit](img/commit.png)

.xx-large[
* Commit message (first commit)
* Identifier of commit (fdf4fc)
]
---
# History is a chain of commits
![A chain of commits](img/commit-chain.png)
---
# What is stored in a commit?
.xx-large[
* A pointer to the `tree` representing the files at this time
* A pointer to the `commit` representing the previous version
* An author
* A message explaining the changes
]
--

## Example

```bash
$ git cat-file commit 86dd3a12
tree d6b5b4b680b0aba4adf0b568f0c4fd55c38d6931
parent b1375ad7e766853bb26688c176cf0264e29fc5f5
author Daan van Vugt <daanvanvugt@gmail.com> 1482404411 +0100
committer Daan van Vugt <daanvanvugt@gmail.com> 1482404411 +0100

Rename particle diagnostics, small fixes
```
---
# Blobs and trees
.xx-large[
* `blob`: Some data, like the content of a file
* `tree`: A list of `blobs` and `trees`, with names
]
.img-width-40[![Simple version of the Git data model](img/data-model-1.png)]

All images in this section from [https://git-scm.com/book/en/v2/Git-Internals-Git-Objects](https://git-scm.com/book/en/v2/Git-Internals-Git-Objects)

---
# Storage of blobs and trees
.xx-large[
* `Blobs` and `trees` are stored as `objects`
* Each `object` is uniquely identified by its `key` (SHA-1 header+contents)
  * Example: `83baae61804e65cc73a7201a7252750c76066a30`
  * Commits are also stored as `objects`!
  * Using the first 6 characters of this key is usually enough
]
.img-width-40[![Storing a tree of Git data](img/data-model-2.png)]

---
# Example set of commits (read bottom to top)
.width-40.float-right[
### Third commit
* Create `bak/test.txt` `"version 1"`

### Second commit
* Create `new.txt` `"new file"`
* Alter `test.txt` to `"version 2"`

### First commit
* Create `test.txt` `"version 1"`
]
.float-left.width-60.img-fit-width[![Commits, trees and blobs](img/data-model-3.png)]
---

# Summary so far
.xx-large[
* Git tracks history as a chain of commits
* All these commits together are called your `repository`
* Each commit stores
  * all files in that commit (a `tree`)
  * a commit message
  * the author
  * the commit time
  * reference to previous commits
* Any `object` in Git (`commit, tree, blob`) has a key (like fdf4fc)
]
---

class: center, middle
# Basic commands

---
# Basic commands
### Creating a git repository - `git init, git clone`
### Prepare files for committing - `git add`
### Committing files to the repository - `git commit`
### Inspecting the repository - `git status, git log`

---
# Creating or cloning a repository
### Create a new repository in the current folder
```bash
$ git init . # Initializes a repository in the current folder (creates .git/)
```
--
### Clone an existing repository
```bash
$ git clone git@gitlab.com:Huijsmans/CP_fusion_2017.git # Clones the repository to CP_fusion_2017 directory
```

---
# `git add` and the staging area
.xx-large[
* Stores all changes meant to go in the following commit
* A way to review exactly what is going to be committed
]
.float-left.width-50.img-fit-width[![The working directory, staging area and repository](img/index1@2x.png)]
--
.width-50.float-right[
```bash
$ echo "version 1" > test.txt # Create a file
$ git add test.txt # Stage this file
$ git commit # Commit this file
```
]
---
# `git commit`
.xx-large[
* Makes a commit out of all files you have `git add`-ed to the staging area
* Opens a text editor for you to write a commit message
  * Use git commit -m "commit message here" to write on console
  * (use `<ESC>:wq` to close vim)
]
---
# Intermezzo: commit messages

.img-width-80[![image by xkcd](http://imgs.xkcd.com/comics/git_commit.png)]
---
# Intermezzo: what makes a good commit message?
.x-large[
* Describe what was changed and why
* Insert a blank line after first line
* Wrap subsequent lines at 72 characters
]

### Model Git commit message
```
Capitalized, short (50 chars or less) summary

More detailed explanatory text, if necessary.  Wrap it to about 72
characters or so.  In some contexts, the first line is treated as the
subject of an email and the rest of the text as the body.  The blank
line separating the summary from the body is critical (unless you omit
the body entirely); tools like rebase can get confused if you run the
two together.

Write your commit message in the imperative: "Fix bug" and not "Fixed bug"
or "Fixes bug." 

- Bullet points are okay, too
```
---

# `git status` shows:
.xx-large[
* Staged changes
  * Changes to `add`-ed files
* Unstaged changes
  * Changes in non-`add`-ed files
* Untracked files
  * Files that are in your working directory but not in the repository
]

```git
$ git status
On branch master

Initial commit

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

    new file:   test.txt
```
---

# More examples of `git status`
```git
On branch master
Changes to be committed:
(use "git reset HEAD <file>..." to unstage)

new file:   newfile.md

Changes not staged for commit:
(use "git add <file>..." to update what will be committed)
(use "git checkout -- <file>..." to discard changes in working directory)

modified:   client/index.html

Untracked files:
(use "git add <file>..." to include in what will be committed)

slides.md
```

Looking at the output from this command, we can see that:

* slides.md is currently not being tracked
* client/index.html has been modified - and is not in staging
* newfile.md is staged and ready to be committed

---
# More examples of `git status` (2)
If we make another change to newfile.md, the output from `git status`
looks like:

``` {.bash}
On branch master
Changes to be committed:
(use "git reset HEAD <file>..." to unstage)

new file:   newfile.md

Changes not staged for commit:
(use "git add <file>..." to update what will be committed)
(use "git checkout -- <file>..." to discard changes in working directory)

modified:   client/index.html
modified:   newfile.md

Untracked files:
(use "git add <file>..." to include in what will be committed)

slides.md
```

---

`git log`
-----
.xx-large[
* Shows information about previous commits
* Many options
  * Draw graphs
  * Filter by author
  * Filter by date
]
## Some examples:

```bash
$ git log
$ git log -3 # last N commits
$ git log --after='yesterday' # logs since yesterday
$ git log --before="2014-01-01" # logs before a date
$ git log --oneline --decorate --graph # logs with a graph for current branch
$ git log --oneline --decorate --graph --all # logs with a graph for all branches
```

---
# Recap - Basic commands
### Creating a git repository - `git init, git clone`
### Prepare files for committing - `git add`
### Committing files to the repository - `git commit`
### Inspecting the repository - `git status, git log`

---
class: center, middle
# Parallel histories: branching and merging
---

# 




---

# Configuration
### Set your name and email address (required before making commits)
```bash
git config --global user.name "Daan van Vugt"
git config --global user.email "daanvanvugt@gmail.com"
```

---
