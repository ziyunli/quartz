---
name: studying-system-design-challenges
description: Use when studying system design interview problems in the Obsidian vault — user wants to run a mock system design interview, study a reference design, or annotate a system design question note with learning callouts.
---

# Studying System Design Challenges

## Overview

Interactive study flow for system design interview problems. Two top-level modes: **mock** (live interview, follows the 4-step framework from "System Design Interview — An Insider's Guide") and **study** (walks an existing reference design section by section). Mock mode has two sub-modes: **coaching** (educational, progressive hints) and **simulation** (realistic, minimal help). Both modes optionally read a working doc as you draw/type — markdown, Obsidian Canvas, or Excalidraw.

## Setup

```dot
digraph setup {
  rankdir=TB;
  node [shape=box];

  start [label="Skill invoked" shape=ellipse];
  ask_path [label="AskUserQuestion:\nQuestion doc path?" shape=box];
  check_path [label="Is it a directory\nor a file?" shape=diamond];
  list_dir [label="Glob *.md in directory\n(skip index files)" shape=box];
  dir_empty [label="Any questions\nfound?" shape=diamond];
  ask_pick [label="AskUserQuestion:\nWhich question?" shape=box];
  load [label="Read the question file" shape=box];
  file_exists [label="File exists?" shape=diamond];
  check_format [label="Has question file\nformat sections?" shape=diamond];
  gen_structure [label="Generate missing sections\nas internal reference\n(Requirements, Design, etc.)" shape=box];
  ask_mode [label="AskUserQuestion:\nMock or Study?" shape=box];
  mock_branch [label="Mock branch" shape=ellipse];
  study_branch [label="Study branch" shape=ellipse];
  ask_submode [label="AskUserQuestion:\nCoaching or Simulation?" shape=box];
  ask_time_mock [label="AskUserQuestion:\nTime target? (default 45 min)" shape=box];
  ask_time_study [label="AskUserQuestion:\nTime target? (default 30 min)" shape=box];
  ask_doc_mock [label="AskUserQuestion:\nWorking doc?\npaste path / scaffold md|canvas|excalidraw\n(default markdown)" shape=box];
  ask_doc_study [label="AskUserQuestion:\nOptional working doc?\nyes/no, then same path/scaffold prompt" shape=box];
  scaffold [label="If scaffold:\ncreate <Question Name> - Working <YYYY-MM-DD>.<ext>\nin question's folder" shape=box];
  begin [label="Begin interview" shape=ellipse];

  start -> ask_path;
  ask_path -> check_path;
  check_path -> list_dir [label="directory"];
  check_path -> load [label="file"];
  list_dir -> dir_empty;
  dir_empty -> ask_pick [label="yes"];
  dir_empty -> ask_path [label="no — inform user\nand re-ask"];
  ask_pick -> load;
  load -> file_exists;
  file_exists -> check_format [label="yes"];
  file_exists -> ask_path [label="no — inform user\nand re-ask"];
  check_format -> ask_mode [label="yes — structured"];
  check_format -> gen_structure [label="no — ad-hoc"];
  gen_structure -> ask_mode;
  ask_mode -> mock_branch [label="mock"];
  ask_mode -> study_branch [label="study"];
  mock_branch -> ask_submode;
  ask_submode -> ask_time_mock;
  ask_time_mock -> ask_doc_mock;
  ask_doc_mock -> scaffold;
  study_branch -> ask_time_study;
  ask_time_study -> ask_doc_study;
  ask_doc_study -> scaffold;
  scaffold -> begin;
}
```

When invoked:

1. **Which question?** Use AskUserQuestion to ask for the path to a question document. The user can:
   - Provide a path to a specific `.md` file anywhere in the vault
   - Provide a path to a directory to list questions from — glob for `*.md` files, exclude index files, mock session retros (`- Mock Session`), and companion docs (`- Question`, `- Reference`), then ask which one
   - **If the directory is empty** (no `.md` question files), inform the user and re-ask
   - **If the file doesn't exist**, inform the user and re-ask
2. **Which top-level mode?** `mock` or `study`
3. **Mock-only sub-mode:** `coaching` or `simulation`
4. **Time target?** Default 45 min for mock, 30 min for study
5. **Working doc?** Ask the user:
   - `paste path` — provide a path to an existing `.md`, `.canvas`, or `.excalidraw.md` file
   - `scaffold` — choose `markdown` (default), `canvas`, or `excalidraw`. The skill creates `<Question Name> - Working <YYYY-MM-DD>.<ext>` in the same folder as the question file via the Obsidian CLI.
   - In **study mode**, this question is prefaced with "Want a doc to sketch as we discuss? (yes/no)" — `no` skips it.

Read the selected question file. If the file follows the question file format (has `## Requirements`, `## High-Level Design`, etc.), proceed directly. If it's an ad-hoc source (notes, articles, clippings), **generate the missing structure first** — silently create internal reference sections (Requirements, Back-of-Envelope, High-Level Design, Deep Dive Topics, Wrap-Up Prompts, Common Mistakes) based on the file's content and your own domain knowledge. Then begin the session using this generated structure as your reference.

## Modes

### Coaching Mode

- After each candidate response, provide brief feedback on what was strong/weak
- Give **progressive hints** (see hint levels below) when the candidate is stuck or missing key topics
- Explain what a strong answer looks like AFTER the candidate has attempted each step
- Call out red flags gently with guidance: "An interviewer would want to see X here"
- Full debrief at end with learning recommendations

### Simulation Mode

- Behave as a realistic interviewer — no teaching during the interview
- Use subtle nudges only: "Anything else you'd want to clarify?" or "Are there other approaches?"
- Do NOT reveal expected answers during the interview
- Full evaluation at end with detailed scoring

## The 4-Step Framework

```dot
digraph interview {
  rankdir=TB;
  node [shape=box];

  start [label="Present question\n(read question file)" shape=ellipse];
  step1 [label="Step 1: Requirements & Scope\n(3-10 min)\nCandidate asks clarifying Qs"];
  gate1 [label="Adequate requirements\ngathered?" shape=diamond];
  nudge1 [label="Nudge: 'Before we design,\nwhat else would you\nwant to clarify?'" shape=box style=dashed];
  step2 [label="Step 2: High-Level Design\n(10-15 min)\nAPI, components, data flow"];
  gate2 [label="Has a reasonable\nblueprint?" shape=diamond];
  nudge2 [label="Nudge: 'Can you walk me\nthrough the main\nuse case end-to-end?'" shape=box style=dashed];
  step3 [label="Step 3: Deep Dive\n(10-25 min)\nKey components in detail"];
  step4 [label="Step 4: Wrap Up\n(3-5 min)\nBottlenecks, improvements"];
  eval [label="Evaluation & Debrief" shape=ellipse];

  start -> step1;
  step1 -> gate1;
  gate1 -> step2 [label="yes"];
  gate1 -> nudge1 [label="no"];
  nudge1 -> step1;
  step2 -> gate2;
  gate2 -> step3 [label="yes"];
  gate2 -> nudge2 [label="no"];
  nudge2 -> step2;
  step3 -> step4;
  step4 -> eval;
}
```

### Step 1 — Requirements & Scope (3-10 min)

**Your role:** Answer the candidate's clarifying questions using the question file's `requirements` section. If the candidate doesn't ask, use the answers to guide what they should be asking about.

**Gate:** Do NOT move to Step 2 until the candidate has:

- Identified core use cases (at least functional requirements)
- Established scale (traffic, storage, or user count)
- Discussed at least one non-functional requirement

**If candidate jumps ahead:** "I appreciate the enthusiasm, but let's make sure we're aligned on requirements first. What questions do you have about the problem?"

**Red flags to catch:**

- Jumping to solution without requirements
- Not asking about scale
- Making assumptions without stating them

### Step 2 — High-Level Design (10-15 min)

**Your role:** React to the candidate's design. Ask about missing components from the question file's `high_level_design` section.

**Gate:** Do NOT move to Step 3 until:

- API endpoints are defined (or at least discussed)
- Major components are identified
- Data flow for core use cases is walkable

**Prompt depth:** "Can you walk me through what happens when a user [core use case]?"

**Back-of-envelope:** If the candidate hasn't done estimation, prompt: "Before we go deeper, should we do some quick math to validate this design can handle our scale?"

### Step 3 — Deep Dive (10-25 min)

**Your role:** Pick 2-3 topics from the question file's `deep_dive_topics` based on what the candidate seems strongest/weakest at. Let the candidate choose one first.

**Coaching mode:** After the candidate discusses a topic, share the reference answer's key points they missed.

**Simulation mode:** Probe with follow-up questions: "What happens if...?", "How would you handle...?", "What are the tradeoffs?"

### Step 4 — Wrap Up (3-5 min)

Ask the candidate:

- "What are the bottlenecks in your design?"
- "If you had more time, what would you improve?"
- "How would you handle [failure scenario from question file]?"

## Progressive Hint System (Coaching Mode Only)

When the candidate is stuck or missing a key concept, escalate through these levels:

| Level | Approach         | Example                                                                                                 |
| ----- | ---------------- | ------------------------------------------------------------------------------------------------------- |
| 1     | Open question    | "How would you generate the short URL?"                                                                 |
| 2     | Narrow the space | "There are two main approaches to key generation — can you think of what they might be?"                |
| 3     | Name the concept | "Have you considered base 62 conversion as an alternative to hashing?"                                  |
| 4     | Explain briefly  | "Base 62 uses a unique ID generator + conversion to get a 7-char string. The tradeoff vs hashing is..." |

Never jump to Level 4. Always start at Level 1 and escalate only if the candidate is stuck after attempting.

## Evaluation Rubric

Score each dimension 1-4:

| Score | Meaning                                                  |
| ----- | -------------------------------------------------------- |
| 1     | Not attempted or fundamentally wrong                     |
| 2     | Attempted but shallow or missing key aspects             |
| 3     | Solid — covers main points with reasonable depth         |
| 4     | Excellent — deep understanding, strong tradeoff analysis |

**Dimensions:**

1. **Requirements gathering** — Did they clarify scope before designing?
2. **Estimation** — Did they do back-of-envelope math?
3. **High-level design** — Is the architecture reasonable and complete?
4. **Deep dive** — Did they show depth on specific components?
5. **Tradeoffs** — Did they discuss pros/cons of their choices?
6. **Communication** — Did they think out loud and respond to feedback?

**Overall recommendation:** Hire / Lean Hire / Lean No Hire / No Hire

**Priority area examples:** After presenting the evaluation and priority areas, provide **concrete examples** the candidate can study. For each priority area, show what a strong answer looks like for this specific question — not generic advice, but the actual words/numbers the candidate should have said. This bridges the gap between "you should do X" and "here's what X looks like in practice."

## Interaction Rules

- **One step at a time.** Present the question, then STOP and wait for the candidate's response. Do not anticipate or script multiple exchanges.
- **Stay in character.** You are the interviewer. Do not break character during the interview (coaching feedback is in-character as a coach-interviewer).
- **Be conversational.** Real interviews are collaborative, not interrogations.
- **Time awareness.** If the candidate is spending too long on one step, gently guide: "We have about X minutes left — shall we move to [next area]?"

## Question File Format

Question files can live anywhere in the vault. Each question file follows this structure:

```markdown
# Question Name

## Prompt

The question as presented to the candidate.

## Requirements

Clarifying Q&A pairs the interviewer should use.

## Back-of-Envelope

Key calculations and expected numbers.

## High-Level Design

Expected components, APIs, data flow.

## Deep Dive Topics

2-4 topics with expected depth, tradeoffs, and common mistakes.

## Wrap-Up Prompts

Follow-up questions and failure scenarios.

## Common Mistakes

What candidates typically get wrong.
```

## Post-Session: Wrap Up

Run this immediately after the evaluation debrief. All four steps are mandatory.

### 2a: Annotate Question File (metadata only)

The question file stays as a **clean problem spec** — only add metadata callouts:

- AI disclosure after frontmatter: `> [!info] AI-assisted annotations` (once, on first session)
- `> [!info] See also` for alternate versions or related notes

Do NOT add retro content, study callouts, or evaluation scores to the question file. Those go in the mock session doc (2b).

### 2b: Create/Update Mock Session Retro

Create a retro note in the **same folder** as the question file:

- **Filename:** `<Question Name> - Mock Session <YYYY-MM-DD>.md`
- **Structure:**
  - Setup block (question wikilink, mode, time target, date)
  - Per-step sections with:
    - What the candidate said/did
    - Study callouts placed **contextually after the relevant step** they relate to:
      - `[!question]` conceptual Q&A and key insights, `[!warning]` gotchas/mistakes, `[!info]` context/patterns, `[!example]` strong points
      - One concept per callout, `==highlights==` for takeaways, no tables inside callouts
  - Evaluation summary table (dimension, score, notes)
  - Priority areas for next session
  - Comparison to previous sessions (if any exist — check for prior mock session files)

If prior mock session retros exist in the same folder, use them as format reference.

### 2c: Update System Design Retro Journal

Find the System Design Retro Journal in the Interview Preparation folder. If it doesn't exist, create it (modeled on Coding Retro Journal). Add an entry following its template format, with a wikilink to the full mock session retro note.

Also update the **Weak Pattern Summary** table at the bottom — patterns that recur across sessions get flagged here.

### 2d: Create Anki Cards

Invoke the `accelerated-learning:creating-anki-cards` skill to create flashcards from the session. Cards go in the project's `anki/` directory. Deck naming convention: `"Interview Prep::System Design::<Topic>"`. Focus on:

- Gotchas and mistakes made during the session
- Key formulas and estimation patterns
- Tradeoffs and design decisions
- Interview technique insights
- Patterns that generalize beyond this specific question

Check existing YAML files to avoid duplicates; add to existing file if the topic already has one.

### 2e: Save Question File (ad-hoc sources only)

If the question source was ad-hoc (user-provided notes, not already in question file format), offer to generate a cleaned-up question file:

1. Ask the user if they want to save a cleaned-up version
2. Generate a question file following the Question File Format above, incorporating:
   - The generated structure used during the session
   - Insights from the session (what the candidate struggled with, common mistakes observed)
   - Any additional depth uncovered during the deep dive
3. Generate a **companion reference document** (`<Name> - Reference.md`) with:
   - Detailed reference answers for each deep dive topic
   - **Mermaid diagrams** for visual study: architecture overview, sequence diagrams for key flows, data model (ER diagram), and any component-specific diagrams (e.g., version control strategy, cost control layers, streaming flow)
   - Tables comparing approaches and tradeoffs
   - Wikilink back to the question file: `Companion to [[<question-file>]]`
4. Save both files in the **same folder as the source question** using the Obsidian CLI. Name them to match the source file's naming style (e.g., if source is `Prompt Playground System Design.md`, use `Prompt Playground - Question.md` and `Prompt Playground - Reference.md`)
5. If a System Design Questions index file exists in or near the source folder, update it with wikilinks to both the question file and reference doc

## Red Flags (Across All Steps)

- Jumping to solution without requirements → redirect to Step 1
- "I think that's a solid design" without depth → probe: "What could go wrong?"
- Only one approach considered → "Are there alternatives? What are the tradeoffs?"
- No numbers anywhere → prompt for back-of-envelope
- Not responding to interviewer feedback → note in evaluation, escalate nudges
