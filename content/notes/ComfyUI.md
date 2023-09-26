---
title: ComfyUI
date: 2023-09-20
---
## Getting Started

See https://github.com/comfyanonymous/ComfyUI#installing for the latest instructions. 

What I did on my Linux PC with an Nvidia GPU:
```sh
git@github.com:comfyanonymous/ComfyUI.git && cd ComfyUI
asdf local python latest # I don't have a global Python
python -m venv venv && source venv/bin/activate

pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu118 xformers
pip install -r requirements.txt
```