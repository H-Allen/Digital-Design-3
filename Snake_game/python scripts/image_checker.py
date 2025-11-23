from PIL import Image

# Parameters
width, height = 160, 120
mem_path = "gameover.mem"

def rgb444_to_rgb888(v):
    """v is 0–4095 (0x000–0xFFF)"""
    r4 = (v >> 8) & 0xF
    g4 = (v >> 4) & 0xF
    b4 = v & 0xF
    # Scale 4-bit (0–15) to 8-bit (0–255)
    r = (r4 * 255) // 15
    g = (g4 * 255) // 15
    b = (b4 * 255) // 15
    return (r, g, b)

# Read and parse mem file
pixels = []
with open(mem_path, "r") as f:
    for line in f:
        line = line.strip()
        if not line:
            continue
        v = int(line, 16)  # hex -> int
        pixels.append(rgb444_to_rgb888(v))

# Sanity check size
expected = width * height
if len(pixels) != expected:
    raise ValueError(f"Expected {expected} pixels, got {len(pixels)}")

# Create image
img = Image.new("RGB", (width, height))
img.putdata(pixels)
img.show()
