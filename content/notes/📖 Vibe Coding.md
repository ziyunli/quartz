---
tags:
  - Books
draft: true
---

Reading notes of [Vibe Coding by Steve Yegge, Gene Kim](https://app.thestorygraph.com/books/97142d27-7b9c-4b6c-8c21-9e641296ecc6)

## Chapter 1

By the end of 2025, it seemed clear that we humans had created something like intelligence in the form of LLMs — or at least mimicked some forms of it by compressing huge amounts of information (mostly from the internet) and shaping the models with human feedback.

What next?

In the book's framing, _[[Vibe Coding]]_ means delegating most implementation to LLMs while steering by intent and review.

And this question can be asked both on a personal level (more on this topic in [[Build To Last]])

> To what degree can you turn your brain off when you use AI to help you create software?

...or on an organization level.

> ...whether companies using vibe coding are setting themselves up for problems down the road.

The book advocates for _vibe coding for grown-ups_

> No one should be writing code by hand anymore _if they don't have to_.

But 

> Delegation of implementation doesn't mean delegation of _responsibility_.

Using a head chef as an example, the responsibility includes:

1. Managing parallel development
2. Handling complex integration
3. Setting (explicit coding) standards
4. Creating onboarding procedures
5. Coordinating larger projects

Though interestingly, it seems like the responsibility is not human-facing, but more about coordinating AIs. Maybe there is going to be more in later chapters.

## Chapter 2

> ...vibe coding allows us to rocket up the abstraction layer, liberating us from details that don't matter: libraries, frameworks, syntax, builders, minifers, and more. 

I am not fully convinced that all these don't matter. My experience with LLM over the past year is that the frontier models write good code, but they don't always align perfectly with the codebase abstraction (if there is even a consistent one) and your mental model. This means you would still spend quite some time to either refactor/polish its raw generated code, or you use the generated code as a prototype and build a more robust version with its idea. Either way requires you to be go below the beautiful abstractions and actually understand and work on the lower-level details. 

The danger if you _don't_ look into (or try to understand) the details, in my opinion, is that the complexity of your implementation quickly compound and explode. It seems to me LLMs are all good at generating codes (i.e. additions), but not particularly great at noticing opportunities to simplify/re-use (i.e. subtractions). In order to keep the complexity under control, the human operator still has to have a deep understanding of the details. 

This also unfortunately means human is the bottleneck. 

> ...that doesn't mean vibe coding is _easy_. On the contrary, your judgement and experience are now more important than ever. 

100%. 

---

_Edited by Codex (gpt-5.2)_
