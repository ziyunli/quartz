---
title: Generative AI
date: 2023-07-16
tags:
  - Blogmarks
---

David Crawshaw shares his experience using LLMs in [How I program with LLM](https://crawshaw.io/blog/programming-with-llms) that can be categorized into three levels:

1. Autocomplete
2. Search
3. Chat-driven programming

**Chat-driven programing**:

> ...A lot of the value I personally get out of chat-driven programming is I reach a point in the day when I know what needs to be written, I can describe it, but I don’t have the energy to create a new file, start typing, then start looking up the libraries I need. (I’m an early-morning person, so this is usually any time after 11am for me, though it can also be any time I context-switch into a different language/framework/etc.) LLMs perform that service for me in programming. They give me a first draft, with some good ideas, with several of the dependencies I need, and often some mistakes. Often, _I find fixing those mistakes is a lot easier than starting from scratch_.

> Give an LLM a specific objective and all the background material it needs so it can craft a well-contained code review packet and expect it to adjust as you question it. There are two major elements to this:>
>
> 1. Avoid creating a situation with so much complexity and ambiguity that the LLM gets confused and produces bad results. This is why I have had little success with chat inside my IDE. My workspace is often messy, the repository I am working on is by default too large, it is filled with distractions. One thing humans appear to be much better than LLMs at (as of January 2025) is not getting distracted. That is why I still use an LLM via a web browser, because I want a blank slate on which to craft a well-contained request.
> 2. Ask for work that is easy to verify. Your job as a programmer using an LLM is to read the code it produces, think about it, and decide if the work is good. You can ask an LLM to do things you would never ask a human to do. “Rewrite all of your new tests introducing an {intermediate concept designed to make the tests easier to read}” is an appalling thing to ask a human, you’re going to have days of tense back-and-forth about whether the cost of the work is worth the benefit. An LLM will do it in 60 seconds and not make you fight to get it done. Take advantage of the fact that **redoing work is extremely cheap**.

**Extra code structure is much cheaper**:

1. As LLMs do better with exam-style questions, more and smaller packages make it easier to give a complete and yet isolated context for a piece of work. With an LLM both doing and benefiting from a big chunk of that extra work, the tradeoff shifts. (As a bonus, we humans get more readable code!)
2. Smaller and more numerous packages can be compiled and tested independently of unrelated code.

> So I foresee a world with far more specialized code, with fewer generalized packages, and more readable tests. Reusable code will continue to thrive around small robust interfaces and otherwise will be pulled apart into specialized code.
