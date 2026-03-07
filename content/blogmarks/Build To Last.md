---
tags:
  - Blogmarks
---

> [!info] AI-assisted annotations
> Cross-references added with Claude Opus 4.6 via Claude Code.

Youtube: [Build to Last — Chris Lattner talks with Jeremy Howard - YouTube](https://www.youtube.com/watch?v=WJS2YDZO-vc)

From [Build to Last – fast.ai](https://www.fast.ai/posts/2025-10-30-build-to-last.html):

On using AI as an organization:

> A lot of evolving a product is not just about getting the results; it’s about the team understanding the architecture of the code.

> Fundamentally, with most kinds of software projects, the software lives for more than six months or a year. The kinds of things I work on, and the kinds of systems you like to build, are things that you continue to evolve.

> This is a huge concern because a lot of evolving a product is not just about getting the results; it’s about the team understanding the architecture of the code. If you’re delegating knowledge to an AI, and you’re just reviewing the code without thinking about what you want to achieve, I think that’s very, very concerning.

> But there’s a problem, because unit tests are their own potential tech debt. The test may not be testing the right thing, or they might be testing a detail of the thing rather than the real idea of the thing… And if you’re using mocking, now you get all these super tightly bound implementation details in your tests, which make it very difficult to change the architecture of your product as things evolve.

> The question is: how productive are people at getting stuff done and making the product better?

On personal growth:

> The question is, when things settle out, where do you as a programmer stand? Have you lost years of your own development because you’ve been spending it the wrong way?

On iteration loops:

> One principle Chris and I share is the critical importance of tight iteration loops. For Chris, working on systems programming, this means “edit the code, compile, run it, get a test that fails, and then debug it and iterate on that loop…

On sharing context with AI:

> the AI should be able to see exactly what the human sees, and the human should be able to see exactly what the AI sees at all times.

> [!info] Related reading
> This interview is the source material for several connected pieces:
>
> - [[../private/courses/solveit-2025/Solve It - 2025|Jeremy Howard's "Solve It" course]] directly teaches the method Lattner and Howard advocate here: ==tight iteration loops, human-driven exploration, AI as learning amplifier==. The Solve It workflow is the practical implementation of "build to last."
> - [[Beyond agentic coding|Gabriella Gonzalez's "Beyond Agentic Coding"]] provides the design theory (calm technology) for why tight iteration loops preserve flow state, and why chat-based agents break it — echoing Lattner's insistence on sub-30-second feedback cycles.
> - [[Agentic Engineering Patterns - Linear walkthroughs|Simon Willison's "Linear Walkthroughs"]] is the counterpoint: vibe code first, then learn via walkthrough. Lattner would likely flag the risk — "delegating knowledge to an AI" — but Willison's pattern at least closes the understanding gap after the fact.

---

From [Jeremy Howard interview at PytorchCon with Anna Tong - YouTube](https://www.youtube.com/watch?v=LrFbxIvsipw)

> - AI Agents Destroying Craftsmanship
>   - "If you outsource everything -- and I'm seeing this happening already, Anna -- people are forgetting how to do work; they're forgetting they _can_ do work. And if the AI can't do it for them, they're just lost."
>     - "I've seen people becoming just depressed that they're no longer competent and they are no longer in control."
> - Short-term Speed vs. Long-term Capability
>   - "In a two-year time frame, I think companies that bet too much on AI outsourcing are risking destroying their company because... they're going to look back and be like, 'Wow, in the effort to get a quick two-week result here, we destroyed our competence as an organization to create things that last.'"
>   - "The people I know who have been diving deep into AI-powered coding... seem to be shipping less but creating more code."
> - AI for Learning vs. Replacement
>   - "I'm using AI now to get better, for me to get better at my work, for me to learn more, for me to get more skills, for me to practice better."
>   - "As AI gets better, it's more and more important that you are too, that your skills are growing faster than the AI's skills."
> - Human Agency
>   - "The agentic approach is like the computer is in control. The human should have agency."
>   - "I feel like as a developer, I'm a much better developer than I was two years ago because I'm all about using AI to help me get better."
> - Contrarian Leadership
>   - "It's no point following, you've got to see where things are going and you've got to lead."
>   - (About the 1st to commit to PyTorch) "Everybody 'knew' Google was going to win. And people were like, 'Why would I come to your course when you're teaching some obscure, open-source, random thing?' Because it's better."
> - The Hedging Argument
>   - "If it is true, and if AI takes over everything and does all the work, then it doesn't matter what you do. You're going to be obsolete, so whatever. On the other hand, I think it's very likely that it won't be true, and people will be very much needed."
