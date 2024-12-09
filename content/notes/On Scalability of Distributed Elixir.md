---
title: On Scalability of Distributed Elixir
---

> [!cite]
>
> People tend to forget that scalability is not a binary property. You always scale up to some users, up to some architecture, up to some amount of nodes. There is no system that will scale to infinity without requiring developer intervention once business needs and application patterns start to settle in.
>
> Distributed Erlang/Elixir *has known limitations*. For example, the network is fully meshed, which gives you about 60 to 200 nodes in a cluster. Or don't send large data over distribution, as that delays the other messages, etc. Some of those are easily solvable. For example, you can rely on your orchestration tools to break your clusters in groups. Or you can setup an out of band tcp/udp socket for large data. Others may be more complex.
>
> The important question, however, is how far you can go without having to tweak, and, once you reach those roadblocks, how well you can address them. In many platforms, writing a distributed system is a no-no or, at best, they require you to assemble and tweak from day one. In this case, the ability to start with Erlang/Elixir and tweak as you grow *is a feature*.
>
> And if you never run into those roadblocks, then you can happily continue running on the default stack. Just look at the many companies using Phoenix PubSub and Phoenix Presence, both distributed, without having to worry about fine-tuning the distribution.[^1]

[^1]: https://news.ycombinator.com/item?id=14748948
