---
created: 2025-11-24
---

Based on [ohmyzsh/plugins/git at beadd56dd75e8a40fe0a7d4a5d63ed5bf9efcd48 · ohmyzsh/ohmyzsh · GitHub](https://github.com/ohmyzsh/ohmyzsh/tree/beadd56dd75e8a40fe0a7d4a5d63ed5bf9efcd48/plugins/git)

## Git Aliases with Explanations

| Alias       | Command                                                                                                                         | Explanation                                          |
| :---------- | :------------------------------------------------------------------------------------------------------------------------------ | :--------------------------------------------------- |
| `grt`       | `cd "$(git rev-parse --show-toplevel \| echo .)"`                                                                               | Jump to repository root directory                    |
| `ggpnp`     | `ggl && ggp`                                                                                                                    | Pull then push current branch (sync with origin)     |
| `ggpur`     | `ggu`                                                                                                                           | Alias for `ggu` (pull rebase current branch)         |
| `g`         | `git`                                                                                                                           | Shorthand for git                                    |
| `ga`        | `git add`                                                                                                                       | Stage specific files                                 |
| `gaa`       | `git add --all`                                                                                                                 | Stage all changes (new, modified, deleted)           |
| `gapa`      | `git add --patch`                                                                                                               | Interactively stage hunks of changes                 |
| `gau`       | `git add --update`                                                                                                              | Stage only modified/deleted files (not new)          |
| `gav`       | `git add --verbose`                                                                                                             | Stage with verbose output                            |
| `gwip`      | `git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"` | Quick work-in-progress commit (skips hooks/CI)       |
| `gam`       | `git am`                                                                                                                        | Apply patches from mailbox                           |
| `gama`      | `git am --abort`                                                                                                                | Abort patch application                              |
| `gamc`      | `git am --continue`                                                                                                             | Continue after resolving conflicts                   |
| `gamscp`    | `git am --show-current-patch`                                                                                                   | Show the patch being applied                         |
| `gams`      | `git am --skip`                                                                                                                 | Skip current patch                                   |
| `gap`       | `git apply`                                                                                                                     | Apply a patch to files                               |
| `gapt`      | `git apply --3way`                                                                                                              | Apply patch with 3-way merge for conflicts           |
| `gbs`       | `git bisect`                                                                                                                    | Binary search for bug-introducing commit             |
| `gbsb`      | `git bisect bad`                                                                                                                | Mark current commit as bad                           |
| `gbsg`      | `git bisect good`                                                                                                               | Mark current commit as good                          |
| `gbsn`      | `git bisect new`                                                                                                                | Mark commit as new (alternative to bad)              |
| `gbso`      | `git bisect old`                                                                                                                | Mark commit as old (alternative to good)             |
| `gbsr`      | `git bisect reset`                                                                                                              | End bisect session                                   |
| `gbss`      | `git bisect start`                                                                                                              | Start bisect session                                 |
| `gbl`       | `git blame -w`                                                                                                                  | Show line-by-line authorship (ignore whitespace)     |
| `gb`        | `git branch`                                                                                                                    | List local branches                                  |
| `gba`       | `git branch --all`                                                                                                              | List all branches (local + remote)                   |
| `gbd`       | `git branch --delete`                                                                                                           | Delete a merged branch                               |
| `gbD`       | `git branch --delete --force`                                                                                                   | Force delete a branch (even unmerged)                |
| `gbgd`      | `LANG=C git branch --no-color -vv \| grep ": gone\]" \| ...`                                                                    | Delete local branches whose remote is gone           |
| `gbgD`      | `LANG=C git branch --no-color -vv \| grep ": gone\]" \| ...`                                                                    | Force delete branches whose remote is gone           |
| `gbm`       | `git branch --move`                                                                                                             | Rename a branch                                      |
| `gbnm`      | `git branch --no-merged`                                                                                                        | List branches not merged into current                |
| `gbr`       | `git branch --remote`                                                                                                           | List remote branches                                 |
| `ggsup`     | `git branch --set-upstream-to=origin/$(git_current_branch)`                                                                     | Set upstream tracking for current branch             |
| `gbg`       | `LANG=C git branch -vv \| grep ": gone\]"`                                                                                      | Show branches whose remote tracking is gone          |
| `gco`       | `git checkout`                                                                                                                  | Switch branches or restore files                     |
| `gcor`      | `git checkout --recurse-submodules`                                                                                             | Checkout with submodule update                       |
| `gcb`       | `git checkout -b`                                                                                                               | Create and switch to new branch                      |
| `gcB`       | `git checkout -B`                                                                                                               | Create/reset and switch to branch                    |
| `gcd`       | `git checkout $(git_develop_branch)`                                                                                            | Switch to develop branch                             |
| `gcm`       | `git checkout $(git_main_branch)`                                                                                               | Switch to main/master branch                         |
| `gcp`       | `git cherry-pick`                                                                                                               | Apply specific commit(s) to current branch           |
| `gcpa`      | `git cherry-pick --abort`                                                                                                       | Abort cherry-pick                                    |
| `gcpc`      | `git cherry-pick --continue`                                                                                                    | Continue cherry-pick after resolving conflicts       |
| `gclean`    | `git clean --interactive -d`                                                                                                    | Interactively remove untracked files/dirs            |
| `gcl`       | `git clone --recurse-submodules`                                                                                                | Clone repo including submodules                      |
| `gclf`      | `git clone --recursive --shallow-submodules --filter=blob:none --also-filter-submodules`                                        | Fast clone (partial clone, shallow submodules)       |
| `gccd`      | `git clone --recurse-submodules "$@" && cd "$(basename $_ .git)"`                                                               | Clone and cd into the repo                           |
| `gcam`      | `git commit --all --message`                                                                                                    | Stage all and commit with message                    |
| `gcas`      | `git commit --all --signoff`                                                                                                    | Stage all and commit with sign-off                   |
| `gcasm`     | `git commit --all --signoff --message`                                                                                          | Stage all, sign-off, with message                    |
| `gcmsg`     | `git commit --message`                                                                                                          | Commit staged changes with message                   |
| `gcsm`      | `git commit --signoff --message`                                                                                                | Commit with sign-off and message                     |
| `gc`        | `git commit --verbose`                                                                                                          | Commit showing diff in editor                        |
| `gca`       | `git commit --verbose --all`                                                                                                    | Stage all and commit with diff in editor             |
| `gca!`      | `git commit --verbose --all --amend`                                                                                            | Amend last commit, staging all changes               |
| `gcan!`     | `git commit --verbose --all --no-edit --amend`                                                                                  | Amend last commit silently (keep message)            |
| `gcans!`    | `git commit --verbose --all --signoff --no-edit --amend`                                                                        | Amend with sign-off, keep message                    |
| `gcann!`    | `git commit --verbose --all --date=now --no-edit --amend`                                                                       | Amend with current timestamp                         |
| `gc!`       | `git commit --verbose --amend`                                                                                                  | Amend last commit                                    |
| `gcn`       | `git commit --verbose --no-edit`                                                                                                | Commit without editing message                       |
| `gcn!`      | `git commit --verbose --no-edit --amend`                                                                                        | Amend without editing message                        |
| `gcs`       | `git commit -S`                                                                                                                 | Commit with GPG signature                            |
| `gcss`      | `git commit -S -s`                                                                                                              | Commit with GPG signature and sign-off               |
| `gcssm`     | `git commit -S -s -m`                                                                                                           | GPG signed commit with sign-off and message          |
| `gcf`       | `git config --list`                                                                                                             | List all git configuration                           |
| `gcfu`      | `git commit --fixup`                                                                                                            | Create fixup commit for autosquash                   |
| `gdct`      | `git describe --tags $(git rev-list --tags --max-count=1)`                                                                      | Show most recent tag                                 |
| `gd`        | `git diff`                                                                                                                      | Show unstaged changes                                |
| `gdca`      | `git diff --cached`                                                                                                             | Show staged changes                                  |
| `gdcw`      | `git diff --cached --word-diff`                                                                                                 | Show staged changes word-by-word                     |
| `gds`       | `git diff --staged`                                                                                                             | Show staged changes (same as --cached)               |
| `gdw`       | `git diff --word-diff`                                                                                                          | Show unstaged changes word-by-word                   |
| `gdv`       | `git diff -w "$@" \| view -`                                                                                                    | View diff ignoring whitespace in vim                 |
| `gdup`      | `git diff @{upstream}`                                                                                                          | Diff against upstream branch                         |
| `gdnolock`  | `git diff $@ ":(exclude)package-lock.json" ":(exclude)*.lock"`                                                                  | Diff excluding lock files                            |
| `gdt`       | `git diff-tree --no-commit-id --name-only -r`                                                                                   | List files changed in a commit                       |
| `gf`        | `git fetch`                                                                                                                     | Download objects/refs from remote                    |
| `gfa`       | `git fetch --all --tags --prune`                                                                                                | Fetch all remotes, tags, prune stale refs            |
| `gfo`       | `git fetch origin`                                                                                                              | Fetch from origin                                    |
| `gg`        | `git gui citool`                                                                                                                | Open git GUI for committing                          |
| `gga`       | `git gui citool --amend`                                                                                                        | Open git GUI to amend                                |
| `ghh`       | `git help`                                                                                                                      | Show git help                                        |
| `glgg`      | `git log --graph`                                                                                                               | Log with ASCII branch graph                          |
| `glgga`     | `git log --graph --decorate --all`                                                                                              | Graph log of all branches with decorations           |
| `glgm`      | `git log --graph --max-count=10`                                                                                                | Graph log limited to 10 commits                      |
| `glod`      | `git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'`                        | Pretty graph log with author date                    |
| `glods`     | `git log --graph --pretty='...' --date=short`                                                                                   | Pretty graph log with short dates                    |
| `glol`      | `git log --graph --pretty='...'`                                                                                                | Pretty graph log with relative dates                 |
| `glola`     | `git log --graph --pretty='...' --all`                                                                                          | Pretty graph log of all branches                     |
| `glols`     | `git log --graph --pretty='...' --stat`                                                                                         | Pretty graph log with file stats                     |
| `glo`       | `git log --oneline --decorate`                                                                                                  | Compact one-line log                                 |
| `glog`      | `git log --oneline --decorate --graph`                                                                                          | Compact log with graph                               |
| `gloga`     | `git log --oneline --decorate --graph --all`                                                                                    | Compact graph log of all branches                    |
| `glp`       | `git log --pretty=<format>`                                                                                                     | Log with custom format                               |
| `glg`       | `git log --stat`                                                                                                                | Log with diffstat                                    |
| `glgp`      | `git log --stat --patch`                                                                                                        | Log with diffstat and full diff                      |
| `gignored`  | `git ls-files -v \| grep "^[[:lower:]]"`                                                                                        | List files marked assume-unchanged                   |
| `gfg`       | `git ls-files \| grep`                                                                                                          | Search tracked filenames                             |
| `gm`        | `git merge`                                                                                                                     | Merge branches                                       |
| `gma`       | `git merge --abort`                                                                                                             | Abort merge                                          |
| `gmc`       | `git merge --continue`                                                                                                          | Continue merge after resolving conflicts             |
| `gms`       | `git merge --squash`                                                                                                            | Squash merge (combine into single commit)            |
| `gmff`      | `git merge --ff-only`                                                                                                           | Merge only if fast-forward possible                  |
| `gmom`      | `git merge origin/$(git_main_branch)`                                                                                           | Merge origin's main into current                     |
| `gmum`      | `git merge upstream/$(git_main_branch)`                                                                                         | Merge upstream's main into current                   |
| `gmtl`      | `git mergetool --no-prompt`                                                                                                     | Launch merge tool                                    |
| `gmtlvim`   | `git mergetool --no-prompt --tool=vimdiff`                                                                                      | Launch vimdiff as merge tool                         |
| `gl`        | `git pull`                                                                                                                      | Fetch and merge from upstream                        |
| `gpr`       | `git pull --rebase`                                                                                                             | Fetch and rebase onto upstream                       |
| `gprv`      | `git pull --rebase -v`                                                                                                          | Verbose pull with rebase                             |
| `gpra`      | `git pull --rebase --autostash`                                                                                                 | Pull rebase, auto-stashing local changes             |
| `gprav`     | `git pull --rebase --autostash -v`                                                                                              | Verbose pull rebase with autostash                   |
| `gprom`     | `git pull --rebase origin $(git_main_branch)`                                                                                   | Rebase current branch onto origin/main               |
| `gpromi`    | `git pull --rebase=interactive origin $(git_main_branch)`                                                                       | Interactive rebase onto origin/main                  |
| `gprum`     | `git pull --rebase upstream $(git_main_branch)`                                                                                 | Rebase onto upstream/main                            |
| `gprumi`    | `git pull --rebase=interactive upstream $(git_main_branch)`                                                                     | Interactive rebase onto upstream/main                |
| `ggpull`    | `git pull origin "$(git_current_branch)"`                                                                                       | Pull current branch from origin                      |
| `ggl`       | `git pull origin $(current_branch)`                                                                                             | Pull current branch from origin                      |
| `gluc`      | `git pull upstream $(git_current_branch)`                                                                                       | Pull current branch from upstream                    |
| `glum`      | `git pull upstream $(git_main_branch)`                                                                                          | Pull main from upstream                              |
| `gp`        | `git push`                                                                                                                      | Push to remote                                       |
| `gpd`       | `git push --dry-run`                                                                                                            | Simulate push                                        |
| `gpf!`      | `git push --force`                                                                                                              | Force push (dangerous!)                              |
| `ggf`       | `git push --force origin $(current_branch)`                                                                                     | Force push current branch                            |
| `gpf`       | `git push --force-with-lease --force-if-includes`                                                                               | Safe force push (checks for upstream changes)        |
| `ggfl`      | `git push --force-with-lease origin $(current_branch)`                                                                          | Safe force push current branch                       |
| `gpsup`     | `git push --set-upstream origin $(git_current_branch)`                                                                          | Push and set upstream tracking                       |
| `gpsupf`    | `git push --set-upstream origin $(git_current_branch) --force-with-lease --force-if-includes`                                   | Force push and set upstream                          |
| `gpv`       | `git push --verbose`                                                                                                            | Verbose push                                         |
| `gpoat`     | `git push origin --all && git push origin --tags`                                                                               | Push all branches and tags                           |
| `gpod`      | `git push origin --delete`                                                                                                      | Delete remote branch                                 |
| `ggpush`    | `git push origin "$(git_current_branch)"`                                                                                       | Push current branch to origin                        |
| `ggp`       | `git push origin $(current_branch)`                                                                                             | Push current branch to origin                        |
| `gpu`       | `git push upstream`                                                                                                             | Push to upstream remote                              |
| `grb`       | `git rebase`                                                                                                                    | Rebase current branch                                |
| `grba`      | `git rebase --abort`                                                                                                            | Abort rebase                                         |
| `grbc`      | `git rebase --continue`                                                                                                         | Continue rebase after resolving conflicts            |
| `grbi`      | `git rebase --interactive`                                                                                                      | Interactive rebase (edit/squash/reorder)             |
| `grbo`      | `git rebase --onto`                                                                                                             | Rebase onto different base                           |
| `grbs`      | `git rebase --skip`                                                                                                             | Skip current commit in rebase                        |
| `grbd`      | `git rebase $(git_develop_branch)`                                                                                              | Rebase onto develop                                  |
| `grbm`      | `git rebase $(git_main_branch)`                                                                                                 | Rebase onto main                                     |
| `grbom`     | `git rebase origin/$(git_main_branch)`                                                                                          | Rebase onto origin/main                              |
| `grbum`     | `git rebase upstream/$(git_main_branch)`                                                                                        | Rebase onto upstream/main                            |
| `grf`       | `git reflog`                                                                                                                    | Show reference log (recovery tool)                   |
| `gr`        | `git remote`                                                                                                                    | Manage remotes                                       |
| `grv`       | `git remote --verbose`                                                                                                          | List remotes with URLs                               |
| `gra`       | `git remote add`                                                                                                                | Add a remote                                         |
| `grrm`      | `git remote remove`                                                                                                             | Remove a remote                                      |
| `grmv`      | `git remote rename`                                                                                                             | Rename a remote                                      |
| `grset`     | `git remote set-url`                                                                                                            | Change remote URL                                    |
| `grup`      | `git remote update`                                                                                                             | Fetch updates from all remotes                       |
| `grh`       | `git reset`                                                                                                                     | Reset HEAD (mixed mode)                              |
| `gru`       | `git reset --`                                                                                                                  | Unstage files                                        |
| `grhh`      | `git reset --hard`                                                                                                              | Reset HEAD, index, and working tree                  |
| `grhk`      | `git reset --keep`                                                                                                              | Reset keeping local changes if possible              |
| `grhs`      | `git reset --soft`                                                                                                              | Reset HEAD only (keep staged)                        |
| `gpristine` | `git reset --hard && git clean --force -dfx`                                                                                    | Nuclear reset (removes everything including ignored) |
| `gwipe`     | `git reset --hard && git clean --force -df`                                                                                     | Hard reset + clean untracked (keeps ignored)         |
| `groh`      | `git reset origin/$(git_current_branch) --hard`                                                                                 | Hard reset to origin's version                       |
| `grs`       | `git restore`                                                                                                                   | Restore working tree files                           |
| `grss`      | `git restore --source`                                                                                                          | Restore from specific source                         |
| `grst`      | `git restore --staged`                                                                                                          | Unstage files (restore index)                        |
| `gunwip`    | `git rev-list --max-count=1 --format="%s" HEAD \| grep -q "--wip--" && git reset HEAD~1`                                        | Undo WIP commit                                      |
| `grev`      | `git revert`                                                                                                                    | Create commit that undoes another                    |
| `grm`       | `git rm`                                                                                                                        | Remove files from index and working tree             |
| `grmc`      | `git rm --cached`                                                                                                               | Remove from index only (untrack)                     |
| `gcount`    | `git shortlog --summary -n`                                                                                                     | Count commits per author                             |
| `gsh`       | `git show`                                                                                                                      | Show commit details and diff                         |
| `gsps`      | `git show --pretty=short --show-signature`                                                                                      | Show commit with GPG signature                       |
| `gstall`    | `git stash --all`                                                                                                               | Stash everything including ignored                   |
| `gstu`      | `git stash --include-untracked`                                                                                                 | Stash including untracked files                      |
| `gstaa`     | `git stash apply`                                                                                                               | Apply stash without removing it                      |
| `gstc`      | `git stash clear`                                                                                                               | Delete all stashes                                   |
| `gstd`      | `git stash drop`                                                                                                                | Delete a specific stash                              |
| `gstl`      | `git stash list`                                                                                                                | List all stashes                                     |
| `gstp`      | `git stash pop`                                                                                                                 | Apply and remove stash                               |
| `gsta`      | `git stash push`                                                                                                                | Create new stash                                     |
| `gsts`      | `git stash show --patch`                                                                                                        | Show stash contents as diff                          |
| `gst`       | `git status`                                                                                                                    | Show working tree status                             |
| `gss`       | `git status --short`                                                                                                            | Compact status                                       |
| `gsb`       | `git status --short -b`                                                                                                         | Compact status with branch info                      |
| `gsi`       | `git submodule init`                                                                                                            | Initialize submodules                                |
| `gsu`       | `git submodule update`                                                                                                          | Update submodules                                    |
| `gsd`       | `git svn dcommit`                                                                                                               | Push to SVN                                          |
| `gsr`       | `git svn rebase`                                                                                                                | Rebase from SVN                                      |
| `gsw`       | `git switch`                                                                                                                    | Switch branches (modern checkout)                    |
| `gswc`      | `git switch -c`                                                                                                                 | Create and switch to new branch                      |
| `gswd`      | `git switch $(git_develop_branch)`                                                                                              | Switch to develop                                    |
| `gswm`      | `git switch $(git_main_branch)`                                                                                                 | Switch to main                                       |
| `gta`       | `git tag --annotate`                                                                                                            | Create annotated tag                                 |
| `gts`       | `git tag -s`                                                                                                                    | Create GPG-signed tag                                |
| `gtv`       | `git tag \| sort -V`                                                                                                            | List tags sorted by version                          |
| `gignore`   | `git update-index --assume-unchanged`                                                                                           | Ignore local changes to tracked file                 |
| `gunignore` | `git update-index --no-assume-unchanged`                                                                                        | Stop ignoring local changes                          |
| `gwch`      | `git log --patch --abbrev-commit --pretty=medium --raw`                                                                         | Detailed log with patches                            |
| `gwt`       | `git worktree`                                                                                                                  | Manage multiple working trees                        |
| `gwtls`     | `git worktree list`                                                                                                             | List worktrees                                       |
| `gwtmv`     | `git worktree move`                                                                                                             | Move worktree                                        |
| `gwtrm`     | `git worktree remove`                                                                                                           | Remove worktree                                      |
| `gk`        | `gitk --all --branches &!`                                                                                                      | Launch gitk GUI                                      |
| `gke`       | `gitk --all $(git log --walk-reflogs --pretty=%h) &!`                                                                           | Launch gitk with reflog                              |
| `gtl`       | `gtl(){ git tag --sort=-v:refname -n --list ${1}* }; noglob gtl`                                                                | List tags matching pattern                           |

---

## Git Workflow Best Practices Using These Aliases

### 1. Starting Work on a Feature

```bash
# Ensure you're on main and up-to-date
gswm                    # switch to main
gprom                   # pull --rebase origin main

# Create feature branch
gswc feature/my-feature # switch -c (create new branch)
gpsup                   # push --set-upstream (publish branch)
```

### 2. Daily Development Cycle

```bash
# Check status frequently
gss                     # status --short

# Stage changes
gapa                    # add --patch (review each hunk - recommended!)
# or
ga file1 file2          # add specific files
# or
gaa                     # add --all (when confident)

# Review before committing
gdca                    # diff --cached (see what's staged)

# Commit
gcmsg "feat: add user authentication"
# or
gc                      # commit --verbose (see diff in editor)
```

### 3. Keeping Branch Updated

```bash
# Periodically sync with main (rebase preferred for clean history)
gfa                     # fetch --all --tags --prune
grbom                   # rebase origin/main

# If conflicts occur
# ... resolve conflicts ...
grbc                    # rebase --continue
# or
grba                    # rebase --abort (start over)

# Push updated branch
gpf                     # push --force-with-lease (safe force push after rebase)
```

### 4. Quick Context Switching

```bash
# Need to switch branches but have uncommitted work?
gwip                    # save work-in-progress commit
gswm                    # switch to main
# ... do other work ...
gsw feature/my-feature  # switch back
gunwip                  # undo WIP commit, restore changes

# Alternative: use stash
gstu                    # stash --include-untracked
gsw other-branch
# ... work ...
gsw feature/my-feature
gstp                    # stash pop
```

### 5. Cleaning Up Commits Before PR

```bash
# Interactive rebase to squash/reorder/edit commits
grbi HEAD~5             # rebase -i last 5 commits
# or
grbi main               # rebase -i since branching from main

# Fix a specific commit (without interactive rebase)
gcfu abc1234            # commit --fixup <commit>
grbi --autosquash main  # rebase will auto-squash fixups
```

### 6. Code Review / Inspecting Changes

```bash
glola                   # log --graph --all (visual branch history)
glo                     # log --oneline (quick overview)
gd                      # diff (unstaged changes)
gdca                    # diff --cached (staged changes)
gsh abc1234             # show (inspect specific commit)
gbl file.py             # blame (who changed what)
```

### 7. After PR is Merged

```bash
gswm                    # switch to main
gprom                   # pull --rebase origin main
gbd feature/my-feature  # branch --delete (cleanup local)

# Cleanup stale branches
gbgd                    # delete local branches whose remote is gone
```

### 8. Emergency: Undo Mistakes

```bash
# Unstage files
grst file.py            # restore --staged

# Discard local changes to file
grs file.py             # restore

# Undo last commit (keep changes)
grhs HEAD~1             # reset --soft

# Undo last commit (discard changes) - DANGEROUS
grhh HEAD~1             # reset --hard

# Find lost commits
grf                     # reflog
gsh HEAD@{2}            # show specific reflog entry
```

### 9. Hotfix Workflow

```bash
gswm                    # switch to main
gprom                   # ensure up-to-date
gswc hotfix/critical    # create hotfix branch
# ... make fix ...
gcmsg "fix: critical security patch"
gpsup                   # push and set upstream
# After merge:
gswm && gprom && gbd hotfix/critical
```

### Key Principles

1. **Prefer `gpf` over `gpf!`** — `--force-with-lease` prevents overwriting others' work
2. **Use `gapa` for staging** — reviewing hunks catches mistakes and keeps commits focused
3. **Rebase feature branches** (`grbom`) — keeps history linear and clean
4. **Use `gwip`/`gunwip`** for quick context switches without losing work
5. **Run `gfa` regularly** — keeps your local refs current
6. **Clean up with `gbgd`** after PRs merge — prevents branch clutter

---

_Edited by Claude (claude-sonnet-4-5-20250514)_
