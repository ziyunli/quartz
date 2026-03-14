---
created: 2026-03-14
---
Git worktrees let you check out multiple branches of the same repo into separate directories simultaneously. Each worktree is its own working tree with its own checked-out branch, but they all share the same `.git` object store. This makes them much cheaper than full clones, while giving you complete isolation between tasks.

## Why worktrees matter for coding agents

Coding agents like Claude Code maintain session context tied to the working directory. If you're juggling multiple tasks in a single checkout, both you and the agent lose context every time you switch branches. Worktrees solve this: I can work on different projects or features in isolation, opening multiple agent sessions without worrying they step on each other.

The original idea comes from a [guide on using git worktrees with Cursor](https://docs.google.com/document/d/1eg4OQcYxk3GJzg3EV6XVrmO-ZwOP1hUMvZJz33g9RJ4), but the workflow is editor-agnostic — it works just as well with vim, Zed, VS Code, or any editor paired with a CLI agent.

## My setup

I group worktrees by project. At any given time I have:

- **One main worktree** as a reference — this is where I can research the latest codebase without worrying about work-in-progress state
- **2-3 project worktrees** for active tasks

I intentionally limit myself to this small number. It's tempting to spin up more, but I find that too many parallel contexts means nothing really sinks in — everything just passes through my brain. Limiting concurrency gives me a chance to actually internalize what I'm working on. I think this is critical in the age of AI-assisted development: you need to grow at least as fast as LLMs, if not faster, and that requires depth over breadth.

```bash
# Create a reference worktree on main
gwt add ../myrepo-main main

# Create project worktrees
gwt add -b feat/auth-refactor ../myrepo-auth main
gwt add -b feat/dashboard-v2 ../myrepo-dashboard main

# List all worktrees
gwtls

# Clean up when done
gwtrm ../myrepo-auth
```

See [[Git Shortcuts]] for the full alias table (`gwt`, `gwtls`, `gwtmv`, `gwtrm`).

## Pain points

### Disk space with large monorepos

Worktrees are cheaper than full clones because they share the `.git` object store — all commits, blobs, trees, and pack files. For a monorepo with long history, that can be tens of gigabytes you don't have to duplicate. But each worktree still checks out the full working tree: every file written to disk, plus building the index. That checkout step is where the time goes when `git worktree add` runs for a while on a large repo. So worktrees save you storage and network time, but the I/O cost of materializing the working tree is the same as a clone. This is where sparse checkout picks up the slack.

There are a few mitigations:

**Sparse checkout** lets you limit each worktree to only the directories you need. Combined with worktrees, you get isolated task contexts that are a fraction of the full repo size:

```bash
# Create a worktree with --no-checkout to skip the expensive full checkout
gwt add --no-checkout ../myrepo-auth -b feat/auth

# Inside the new worktree, initialize sparse checkout in cone mode
cd ../myrepo-auth
git sparse-checkout init --cone

# Only materialize the directories you need
git sparse-checkout set apps/my-service libs/shared-utils

# Now do the actual checkout — only the specified directories get written to disk
git checkout

# Verify what's included
git sparse-checkout list
```

You can automate this further by wrapping the above into a single command. The tricky part in a real monorepo is dependency expansion — your code likely depends on directories outside the ones you specified. A good wrapper tool would automatically discover and add these by:

- Querying build systems (e.g. Bazel) for transitive dependencies
- Parsing module files (e.g. `go.mod` replace directives) for local paths
- Recursively resolving symlinks that point outside the sparse cone
- Extracting ancestor config files (ESLint, Prettier, etc.) via `git cat-file` without expanding those full directories

For files needed outside the sparse cone (like `go.mod`/`go.sum`), you can surgically extract them with `git cat-file blob HEAD:<path>` and write them directly to the worktree, keeping the sparse set small while satisfying tooling requirements. Done well, this approach yields 70-90% disk savings compared to a full checkout.

My own approach is simpler: I keep a constant number of worktrees (recycling rather than accumulating) and bumped up disk on my remote dev instance. The sparse checkout approach is worth exploring for anyone who can't just throw hardware at the problem.

### Session management

Claude Code ties sessions to the working directory, which means each worktree gets its own session history. This is mostly a feature — it preserves context per task. But it makes it hard to find where you left off when you have multiple worktrees.

What I'd like to see is a global "session search/summary" CLI that lets you list recent sessions across all directories, search by topic, and jump back into the right one. Something like:

```bash
# Hypothetical
claude sessions list --all        # show sessions across all worktrees
claude sessions search "auth"     # find the session where you were working on auth
```

For now, I work around this by keeping my worktree count low and using descriptive branch names that remind me what each session was about.
