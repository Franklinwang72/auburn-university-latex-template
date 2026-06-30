#!/usr/bin/env python3
"""Render a cross-section of a Calabi-Yau manifold (the Fermat quintic
z1^n + z2^n = 1) for the accessible Auburn ETD template, Figure 2.1.

This is the classic visualisation: a real 2-surface inside the complex
Calabi-Yau, drawn as n*n patches and projected from 4D down to 3D.
Output: calabi-yau.png (high-DPI raster, embedded by figures/...).
"""
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.colors import LightSource

n = 5                 # degree of the hypersurface (quintic)
res = 60              # grid resolution per patch
angle = 0.4 * np.pi   # 4D -> 3D projection angle

# Parameter grid: theta = a + i b, with a in [0, pi/2], b in [-1, 1].
a = np.linspace(0.0, np.pi / 2.0, res)
b = np.linspace(-1.0, 1.0, res)
A, B = np.meshgrid(a, b)
theta = A + 1j * B

fig = plt.figure(figsize=(6.4, 6.0))
ax = fig.add_subplot(111, projection="3d")

cmap = plt.get_cmap("viridis")
ls = LightSource(azdeg=315, altdeg=55)

for k1 in range(n):
    for k2 in range(n):
        z1 = np.exp(2j * np.pi * k1 / n) * (np.cos(theta)) ** (2.0 / n)
        z2 = np.exp(2j * np.pi * k2 / n) * (np.sin(theta)) ** (2.0 / n)
        x = z1.real
        y = z2.real
        z = z1.imag * np.cos(angle) + z2.imag * np.sin(angle)
        # colour by the projected-out 4th coordinate (a smooth scalar)
        w = z1.imag * np.sin(angle) - z2.imag * np.cos(angle)
        wn = (w - w.min()) / (w.max() - w.min() + 1e-9)
        rgb = cmap(wn)[..., :3]
        # hillshade the patch by its own elevation so folds read in 3D
        shaded = ls.shade_rgb(rgb, z, blend_mode="soft", vert_exag=1.2)
        ax.plot_surface(
            x, y, z,
            facecolors=shaded,
            rstride=1, cstride=1,
            linewidth=0, antialiased=True, shade=False,
        )

ax.set_box_aspect((1, 1, 1))
ax.set_axis_off()
ax.view_init(elev=22, azim=35)
ax.dist = 7
fig.subplots_adjust(left=0, right=1, bottom=0, top=1)
fig.savefig("calabi-yau.png", dpi=220, transparent=True)
print("wrote calabi-yau.png")
