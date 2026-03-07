---
tags:
  - Courses
---

Lecture: [How to Solve it With Code Lesson 1—Intro & examples - YouTube](https://youtube.com/live/7T83srD0Mu4)

### The Solve It Method: A Philosophy of Craft

The course "How to Solve It With Code" is taught by Jeremy Howard (Fast.ai) and Johno Whitaker. Its central thesis is that **the method and the thinking matter more than which buttons to click**. The course teaches a general approach to problem-solving with code -- one that applies equally to writing software, composing articles, reading papers, or spinning up servers.

#### Why Not Just Outsource Everything to AI?

A recurring theme: outsourcing too much to AI erodes both **competence** and **confidence**. As Andrej Karpathy put it: _"When you build something from scratch, you're forced to come to terms with what you don't understand... It always leads to a deeper understanding."_ If you never build things yourself, you never develop that understanding.

The course uses a platform called **Solve It**, designed specifically for **human-agent collaboration** -- where the human drives the process and learns as they go. The AI assists but does not replace the human's engagement with the problem.

> [!question] How does this relate to the "calm technology" critique of agentic coding?
> Jeremy's philosophy aligns closely with Gabriella Gonzalez's argument in "Beyond Agentic Coding": ==the human should stay in direct contact with the work, not interact through a mediating agent==. The Solve It workflow is essentially a calm technology pattern -- the AI augments the human's editing experience (suggestions, explanations, reorganization) without becoming the center of attention. The difference: Gonzalez frames it as a UI design problem, while Jeremy frames it as a learning and competence problem. Both arrive at the same conclusion -- over-delegation to agents degrades the outcome.

#### Small Steps, Compounding Returns

Jeremy demonstrates this philosophy with a real example from Solve It's own codebase: replacing the GitPython library with a ~20-line custom wrapper. The initial investment seemed wasteful -- two people spending hours on something that "already worked." But Johno highlights the **compounding interest** of that investment: months later, every interaction with Git in the codebase is a pleasure because of that upfront work. Even if the payoff were only one-to-one, the **deliberate practice**, **learning**, and **enjoyment** have independent value.

> [!question] Doesn't this contradict YAGNI?
> On the surface, rewriting a working library wrapper sounds like over-engineering. But Jeremy's argument is subtler: ==the investment pays off in reduced friction across every future interaction==, not in added features. YAGNI says don't build features you don't need; this says invest in the quality of code you _do_ use daily. The distinction is between unnecessary complexity (bad) and unnecessary simplicity debt (also bad). If a dependency makes your codebase harder to understand, replacing it with 20 lines you fully control is the YAGNI-compatible move.

### Example 1: Advent of Code (Day 1, 2024)

Jeremy walks through solving an Advent of Code problem to demonstrate the Solve It workflow.

#### The Workflow

1. **Start with the small example** -- always work through the provided example by hand before tackling the full input. Most people forget this outside of Advent of Code and immediately try to process terabytes of data.

2. **Explore interactively** -- use Python's dynamic introspection (`__dict__`, tab completion, `shift+tab` for docstrings) to understand data and APIs. These are _always perfectly correct_ because they come from the live interpreter, not static annotations.

3. **Make things a little bit better, one step at a time** -- Jeremy's thinking process is simply: _"What's a single step I could do to get this into a slightly better shape?"_ String to list of lines. Lines to split pairs. Pairs to sorted integer lists. Each step is inspected before moving on.

4. **Inspect every output** -- Johno calls this out explicitly: at every stage, you're not just writing code you _think_ is correct -- you're printing the result and _verifying_ it matches expectations. This is how you catch mistakes when they're only 2-4 lines old.

> [!info] The 2-4 line error window
> This is the core invariant of the Solve It method: ==if you always inspect after a small step, the bug is always in the last 2-4 lines you wrote==. You never need a debugger, a stack trace, or `print` statements scattered across a file. This is the same principle behind TDD's red-green-refactor cycle, but applied at the REPL level rather than the test suite level. The tradeoff: it requires discipline to resist writing 20 lines before checking. Jeremy acknowledges this is a habit that takes deliberate practice to build.

5. **Combine exploratory cells into a function** -- after building up the solution piece by piece, copy the working fragments into a single function. Debug errors in the function (like forgetting a `return` statement) which are trivial because you already know each piece works.

#### Learning Along the Way

Even for a trivial problem, Jeremy pushes himself to learn: asking Solve It for a more concise Python idiom (list comprehension with `zip`), then rewriting the solution in **NumPy** for fun. The point is not that NumPy is needed here -- it is that **every problem is an opportunity to develop your craft**.

Johno frames this as the course's "number one prize outcome": cultivating the **curiosity mindset** -- finishing a solution and then wondering, _"Huh, I wonder if I can solve that using NumPy instead?"_

#### On Keeping Exploratory Work

Should you clean up and delete the exploration? Generally **no** -- if a problem was hard enough to require exploration, your colleagues (or future you) will benefit from seeing the step-by-step reasoning. Err on the side of keeping the artifact. Jeremy's open-source library **Claudette** is written this way: the notebook _is_ the documentation, showing the author's thought process from first API call onward.

### Example 2: Writing a Technical Article

Jeremy describes writing an article based on his interview with **Chris Lattner** (creator of LLVM, Swift, MLIR, Mojo) — the [[Build To Last]] article. The article was good enough that Tim O'Reilly personally emailed asking to publish it.

#### The Process

1. **Start with real words, not a blank page** -- the raw material was a transcript of a real conversation. Asking an AI to write from scratch produces generic slop; starting from a transcript makes it a **style transfer** problem, which AI handles well.

2. **Use AI to organize, not to write** -- Jeremy asks the AI to list themes, extract quotes, and suggest narrative paths. There is _no risk of hallucination_ because the source material is a transcript Jeremy participated in and can verify.

3. **Edit the output, don't negotiate with the AI** -- rather than having long back-and-forth conversations trying to get the AI to produce what you want, let it generate a draft, then **directly edit the output** to be what you want. This is faster and also teaches the model your style for subsequent generations.

4. **Autoregressive models predict the next word based on context** -- if your conversation is full of good prose written your way, the AI will produce more like it. If it is full of rejected garbage, the AI gets better at producing garbage. This is why editing outputs (rather than saying "no, try again") produces better results over time.

> [!example] Edit vs. Negotiate: a concrete comparison
>
> - **Negotiating** (worse): "No, that's too formal. Make it more casual. No, now it's too slangy. Try again but keep the technical depth..." -- each rejected attempt pollutes the context with bad examples, and the model's predictions regress toward the mean of all the garbage.
> - **Editing** (better): The AI drafts a paragraph. You rewrite the first sentence to sound like you, keep the second, delete the third. Now the context contains ==your actual voice==, and the next generation builds on that. The conversation becomes a curated corpus of good writing rather than a graveyard of rejected attempts.

5. **Incorporate feedback iteratively** -- after showing the draft to colleagues and his wife Rachel (co-founder of Fast.ai), Jeremy received feedback that he had "buried the lede." He went back into Solve It, told the AI the feedback, asked for relevant quotes, and drafted a new opening.

#### The Interview Trick for Finding Your Voice

When starting from a truly blank slate, Jeremy has a colleague **interview him** about the topic. He records it, discards the interview itself, and uses the transcript as raw material. This avoids defaulting to a bland essay voice or hype-salesman voice -- when you talk to a friend, **you sound like you**.

> [!info] Why the interview trick works
> This exploits a quirk of human cognition: ==we are better speakers than writers==. In conversation, we naturally use concrete examples, vary our pacing, and respond to implicit "why should I care?" signals from the listener. Writing from scratch activates a different, more self-conscious mode that tends toward either academic stiffness or marketing bluster. The transcript captures the authentic version; the AI then handles the mechanical work of converting spoken rhythm to written structure -- a style transfer task it excels at.

### Example 3: Building an SVG Arena App (Johno's Demo)

Johno demonstrates building a complete web application in Solve It: an **SVG Arena** where two LLMs generate images from a prompt and users vote on which is better. ([Full dialog](https://share.solve.it.com/d/c4df5d467533c20a5e0538bd679cfa8a))

#### Planning in Small Pieces

Rather than giving the whole idea to AI at once, Johno breaks it into components:

1. **OpenRouter integration** — unified API client (`OpenAI` compatible) to access multiple models (Grok, Claude, Gemini, GLM, MiniMax)
2. **SVG generation** — prompt engineering to get raw SVG output, plus string-based extraction (`r[r.find("<svg"):r.find("</svg>")+6]`) to tolerate model variations
3. **FastHTML UI** — Sakura CSS styling, HTMX for no-reload interactions, flexbox side-by-side SVG display
4. **Voting and ranking** — in-memory vote storage, simple tally system (winner +1, loser -1), sorted leaderboard
5. **Polish** — OOB (out-of-band) HTMX swaps to reset the form while updating results simultaneously

Each piece is built and tested independently in Jupyter before being combined. Components are displayed with `IPython.display.HTML` to verify SVG rendering inline.

#### Reading the Docs Is Still Valuable

For OpenRouter integration, Johno went directly to the documentation rather than asking AI. Jeremy endorses this: _"The curated first starting point provided by the company that created the software is generally better than the random thing that AI generates."_ Reading docs is "highly underrated" even in the age of AI.

> [!warning] When AI-generated docs are worse than the real thing
> LLMs are trained on a snapshot of the internet. For any API that has changed since training (and most active ones have), ==the AI's knowledge is stale by default==. Worse, it will confidently present outdated or hallucinated endpoints as fact. Official docs are authoritative, current, and often include edge cases the LLM has never seen. The rule of thumb: use AI to _explain_ docs you've already found, not to _replace_ reading them.

#### Leveraging the Browser

Jeremy highlights an underappreciated advantage of working in a browser-based environment: browsers can natively render SVGs, play audio, show interactive UI elements. The AI can generate these, inspect them, and iterate -- all without switching tools or setting up external services.

#### Live Modification Without Restarts

Because FastHTML runs from the live Python interpreter (no build step), Johno can modify routes and UI in his notebook and the running public app updates immediately. This mirrors how **Lisp** and **Smalltalk** used to work -- a style "slightly lost to time" but extremely powerful for iterative development.

> [!info] The lost art of live programming
> The Lisp/Smalltalk tradition of ==modifying a running program without restarting== was the dominant paradigm before compiled languages took over. The key insight: when the feedback loop is instant (change code → see result), exploration is cheap and the developer stays in flow. Modern web dev's compile-bundle-reload cycle broke this. FastHTML's notebook-based approach recovers it by keeping the server in the same Python process as the notebook. This is also why Jeremy insists on notebooks as the primary development environment -- they are the closest modern equivalent to a Lisp REPL.

### Key Takeaways

- **Make steps smaller, iterations faster, and feedback more direct.** If you have an error, it should only be because the last 2-4 lines of code had a problem. You should never need a debugger.
- **Keep things simple and decoupled.** If understanding your codebase requires looking at 15 files, that is the problem to solve first. Solve It itself (a production app built by a 9-person team over a year+) is only 9 notebooks.
- **Beware over-investing in agentic AI.** Answer.AI itself fell into this trap -- Solve It's codebase became overly complicated, and they had to pause feature development for months to simplify until every team member could hold the whole system in their head.
- **Practice deliberately.** The Solve It method requires unlearning habits (writing many lines before checking output, planning extensively before coding). It takes repetition to internalize, but the payoff compounds.

> [!info] Related reading
>
> - [[Build To Last]] — the Chris Lattner interview Jeremy uses as Example 2's source material. Lattner's core argument: ==team understanding of architecture matters more than shipping speed==. His "tight iteration loops" principle (sub-30-second feedback) is the systems-programming version of Jeremy's "inspect every output."
> - [[Beyond agentic coding|Gabriella Gonzalez's "Beyond Agentic Coding"]] provides the design theory behind what Howard practices intuitively. Her **calm technology** framework explains _why_ the Solve It workflow preserves flow: the AI stays on the periphery, the human stays in direct contact with the code. Both arrive at the same critique of chat-based agents from different angles — Gonzalez from UI design, Howard from pedagogy.
> - [[Agentic Engineering Patterns - Linear walkthroughs|Simon Willison's "Linear Walkthroughs"]] represents the opposite end of the spectrum: vibe code first, then learn via AI-generated walkthroughs. Howard would likely argue this leaves understanding on the table — ==the learning that happens during construction is different from the learning that happens during review==. But Willison's pattern is pragmatic when the goal is rapid exploration of an unfamiliar ecosystem.
>   o
