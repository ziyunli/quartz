---
title: "Practical Deep Learning for Coders 2022"
tags:
- Course
---

Progress:
- [x] [1: Getting started](https://course.fast.ai/Lessons/lesson1.html)
- [x] [2: Deployment](https://course.fast.ai/Lessons/lesson2.html)
- [x] [3: Neural net foundations](https://course.fast.ai/Lessons/lesson3.html)
- [ ] [4: Natural Language (NLP)](https://course.fast.ai/Lessons/lesson4.html)

# 2. Deployment

Before you clean the data, you train the model. Why?

> To find out what things are difficult to recognize in your data, and to find the things that the model can help you find data problems.

Look at
- confusion matrix
- top losses `plot_top_losses`
  - images that the model is most confident about but wrong, or
  - images that the model is the least confident about but right

Then use `ImageClassifierCleaner` to clean the data.

Terms:
- Data augmentation:
