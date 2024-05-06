---
title: Issues between asdf and Anaconda
---

Setting a global Python with `.tool-versions` using `asdf` doesn't work well with Anaconda: even if you activate an environment with `conda activate`, `python` still resolves to the `asdf` global Python version.

My workaround:

1. Do _not_ set a global default Python version in `.tool-versions`
2. Continue to use `conda activate` in projects where you need it.
3. In the folder of a Python project you _want_ to use `asdf`, set a local `.tool-versions`.