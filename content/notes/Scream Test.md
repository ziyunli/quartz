---
title: Scream Test
date: 2023-07-10
tags:
  - Software-Engineering
---

[What is a scream test?](https://www.v-wiki.net/scream-test-meaning/)

> [!cite]
> The Scream Test is simple – ==remove it and wait for the screams==. If someone screams, put it back. The Scream Test can be applied to any product, service or capability – particularly when there is poor ownership or understanding of it’s importance.
> ...
> The important part is that the scream test must have a ==simple and rapid way to return service==, if someone actually screams and complains.

The article offers a list of due diligence to execute a scream test

1. Looks for documentation to find out
   1. ownership,
   2. interested parties, and
   3. the purpose of the system
2. Disable monitoring and alerting
   1. Sometimes, this might be hard
3. Do a soft disable for a short period of time (e.g., an hour or so), then return it to service. **Wait for people to react and raise support tickets.**
   1. ==How long do you want to wait==?
   2. ==How channels do you watch for support tickets==?
4. For a server, restart the entire system during the day, to ensure there is no in-memory configuration that is unknown
   1. ==How do you recover the in-memory configuration==?
5. Disable the system or service completely
6. Before deleting the system, you may want to archive the data and document the configuration, in case of a delayed scream.

This is brought up in a HN thread, [InfluxDB Cloud shuts down in Belgium; some weren't notified before data deletion](https://news.ycombinator.com/item?id=36657829). While I can see it might be hard to pull off (see the above highlighted questions that I can think of), it seems to be a good strategy to deprecate enterprise systems or services which are usually very hard to find the right point of contacts.
