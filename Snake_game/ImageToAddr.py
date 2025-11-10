from PIL import Image

# Load and resize to desired VGA display area
img = Image.open("snake.png").convert("RGB")
img = img.resize((64, 64))  # adjust to fit your display area

with open("snake.mem", "w") as f:
    for y in range(img.height):
        for x in range(img.width):
            r, g, b = img.getpixel((x, y))
            r >>= 4
            g >>= 4
            b >>= 4
            color12 = (r << 8) | (g << 4) | b
            f.write(f"{color12:03X}\n")