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
## Examples and use cases
## Advanced uses

---
class: center, middle
# The design of Git
---
# Objects
.xx-large[
* The core of Git is a key-value store.
  * Put in a value (any content, like a file)
  * Get a key (the SHA-1 hash of the file)
  * Use this key later to retrieve the value
]
---
# Blobs and Trees
.xx-large[
* `blob`: Just a bunch of data, like file contents
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
* Using the first 6 characters of this is usually enough
]
.img-width-40[![Storing a tree of Git data](img/data-model-2.png)]

---
# Commits
.xx-large[
* A `commit` is a snapshot of the project in time
* It contains 
  * a pointer to the `tree` representing the files at this time
  * a pointer to the `commit`(s) representing the previous version
  * an author
  * a message explaining the changes
* Also stored as an `object`!
]
---
# Commits (example, read bottom to top)
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

# Summary
.xx-large[
* Git stores objects
* Objects are:
  * Blob (file)
  * Tree (set of files and directories)
  * Commit (Tree, previous commit, message)
* These are organized such that file history can be viewed
]
---

class: center, middle
# Basic commands
