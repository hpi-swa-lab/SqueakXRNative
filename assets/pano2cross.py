import sys
import numpy as np
from PIL import Image

Image.MAX_IMAGE_PIXELS = None
src, dst, n = sys.argv[1], sys.argv[2], int(sys.argv[3])
pano = np.asarray(Image.open(src).convert("RGB"))
h, w, _ = pano.shape

t = (np.arange(n) + 0.5) / n * 2 - 1
a, b = np.meshgrid(t, t)
one = np.ones_like(a)
faces = {
    "+x": (one, -b, -a),
    "-x": (-one, -b, a),
    "+y": (a, one, b),
    "-y": (a, -one, -b),
    "+z": (a, -b, one),
    "-z": (-a, -b, -one),
}
cells = {"+x": (2, 1), "-x": (0, 1), "+y": (1, 0), "-y": (1, 2), "+z": (1, 1), "-z": (3, 1)}

out = np.zeros((3 * n, 4 * n, 3), dtype=np.uint8)
for key, (x, y, z) in faces.items():
    length = np.sqrt(x * x + y * y + z * z)
    x, y, z = x / length, y / length, z / length
    u = 0.5 + np.arctan2(x, -z) / (2 * np.pi)
    v = 0.5 - np.arcsin(y) / np.pi
    px = np.clip((u * w).astype(int), 0, w - 1)
    py = np.clip((v * h).astype(int), 0, h - 1)
    cx, cy = cells[key]
    out[cy * n:(cy + 1) * n, cx * n:(cx + 1) * n] = pano[py, px]

Image.fromarray(out).save(dst)
print(out.shape)
