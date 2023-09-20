---
title: Learning GFX
date: 2023-09-17
---
## OpenGL

### Check the supported OpenGL version

```sh
sudo apt install mesa-utils
glxinfo | grep "OpenGL"
```

Example:
```
OpenGL vendor string: NVIDIA Corporation
OpenGL renderer string: NVIDIA GeForce GTX 1660 SUPER/PCIe/SSE2
OpenGL core profile version string: 4.6.0 NVIDIA 470.199.02
OpenGL core profile shading language version string: 4.60 NVIDIA
OpenGL core profile context flags: (none)
OpenGL core profile profile mask: core profile
OpenGL core profile extensions:
OpenGL version string: 4.6.0 NVIDIA 470.199.02
OpenGL shading language version string: 4.60 NVIDIA
OpenGL context flags: (none)
OpenGL profile mask: (none)
OpenGL extensions:
OpenGL ES profile version string: OpenGL ES 3.2 NVIDIA 470.199.02
OpenGL ES profile shading language version string: OpenGL ES GLSL ES 3.20
OpenGL ES profile extensions:
```