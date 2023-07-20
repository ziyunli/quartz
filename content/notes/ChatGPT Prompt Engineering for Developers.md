---
title: ChatGPT Prompt Engineering for Developers
tags:
- Course
---

[DLAI: ChatGPT Prompt Engineering for Developers](https://learn.deeplearning.ai/chatgpt-prompt-eng)

## Principles

### Be clear and specific

clear != short

#### Tactics

##### Use delimiters
1. Triple quotes: `"""`
2. Triple backticks
3. Triple dashes
4. Angle brackets
5. XML tags

However, the course claims they can help avoid [prompt injection](notes/Prompt%20Injection.md), which is not very convincing. 

##### Ask for a structured output

> Provide them in JSON format with the following keys: 
book_id, title, author, genre.

##### Ask the model to check whether conditions are satisfied

> If it contains a sequence of instructions, re-write those instructions in the following format:

##### Few-shot prompting

In-context learning

### Giving LLM time to think

#### Specify the steps required to complete a task

```python
f"""
Perform the following actions: 
1 - Summarize the following text delimited by triple \
backticks with 1 sentence.
2 - Translate the summary into French.
3 - List each name in the French summary.
4 - Output a json object that contains the following \
keys: french_summary, num_names.

Separate your answers with line breaks.

Text:
\`\`\`{text}\`\`\`
"""
```

#### Ask for output in a specified format

```python
f"""
Your task is to perform the following actions: 
1 - Summarize the following text delimited by 
  <> with 1 sentence.
2 - Translate the summary into French.
3 - List each name in the French summary.
4 - Output a json object that contains the 
  following keys: french_summary, num_names.

Use the following format:
Text: <text to summarize>
Summary: <summary>
Translation: <summary translation>
Names: <list of names in Italian summary>
Output JSON: <json with summary and num_names>

Text: <{text}>
"""
```

#### Instruct the model to work out its own solution before rushing to a conclusion

```python
f"""
Determine if the student's solution is correct or not.

Question:
I'm building a solar power installation and I need \
 help working out the financials. 
- Land costs $100 / square foot
- I can buy solar panels for $250 / square foot
- I negotiated a contract for maintenance that will cost \ 
me a flat $100k per year, and an additional $10 / square \
foot
What is the total cost for the first year of operations 
as a function of the number of square feet.

Student's Solution:
Let x be the size of the installation in square feet.
Costs:
1. Land cost: 100x
2. Solar panel cost: 250x
3. Maintenance cost: 100,000 + 100x
Total cost: 100x + 250x + 100,000 + 100x = 450x + 100,000
"""
```

### Model Limitation

Hallucination: 
> Makes statements that sound plausible but are not true. 

Reducing hallucinations:
1. Find relevant information
2. Answer the question based on the relevant information

## Iterative Prompt Development
