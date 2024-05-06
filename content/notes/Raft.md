---
title: Raft
---

Notes about implementing Raft (or how I struggled with MIT 6.824 Lab 2).

## Building the Mental Model

For someone who doesn't read academic papers regularly, it takes me a while to wrap my head around and understand all the components of the protocol, and how they interact with each others. I found the [Raft Visualization](https://thesecretlivesofdata.com/raft/) by [@benbjohnson](https://twitter.com/benbjohnson) to be very helpful while reading the paper to build a good mental model of the overall protocol. The [diagram of Raft interactions](https://pdos.csail.mit.edu/6.824/notes/raft_diagram.pdf) is another useful reference, both for understanding the paper and implementing it.

I watched the 2020 version lectures [Part 1](http://nil.csail.mit.edu/6.824/2020/video/6.html)([notes](http://nil.csail.mit.edu/6.824/2020/notes/l-raft.txt)), [Part 2](http://nil.csail.mit.edu/6.824/2020/video/7.html)([notes](http://nil.csail.mit.edu/6.824/2020/notes/l-raft2.txt)) by Robert Morris. I found them to help a lot in reinforcing the algorithm and highlights some core ideas, though they also require you to be reasonably understanding the paper to catch up. Make sure you read the entire paper at least for once before watching.

- Periodic Goroutines
    - `ticker`: manage election timers
    - `heartbeats`: send out empty `AppendEntries` from the leader to the peers.
    - `apply`: apply committed logs to the state machine, notified by a condition variable.