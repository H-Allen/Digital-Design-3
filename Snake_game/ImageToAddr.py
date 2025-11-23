from PIL import Image
import os

# Parameters
input_image = "gameover.png"       # Input file
output_mem = "gameover.mem"          # Output file
target_width, target_height = 160, 120

# Open, resize, and convert to RGB
img = Image.open(input_image).resize((target_width, target_height)).convert("RGB")
img.show()

with open(output_mem, "w") as f:
    for y in range(target_height):
        for x in range(target_width):
            r, g, b = img.getpixel((x, y))

            # Convert 8-bit → 4-bit by shifting right
            r4 = r >> 4
            g4 = g >> 4
            b4 = b >> 4

            # Pack into 12-bit RGB (0xRGB)
            pixel_12bit = (r4 << 8) | (g4 << 4) | b4

            # Write as 3-digit hex (e.g., "f34")
            f.write(f"{pixel_12bit:03x}\n")
