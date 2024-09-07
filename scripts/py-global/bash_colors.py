from rich.console import Console
from rich.columns import Columns
from rich.panel import Panel

console = Console()


def get_contrasting_color(r, g, b):
    brightness = (r * 299 + g * 587 + b * 114) / 1000
    return "black" if brightness > 127 else "white"


def color_swatch(color):
    if color < 16:
        # Standard colors
        if color < 8:
            r, g, b = [
                (0, 0, 0),
                (128, 0, 0),
                (0, 128, 0),
                (128, 128, 0),
                (0, 0, 128),
                (128, 0, 128),
                (0, 128, 128),
                (192, 192, 192),
            ][color]
        else:
            r, g, b = [
                (128, 128, 128),
                (255, 0, 0),
                (0, 255, 0),
                (255, 255, 0),
                (0, 0, 255),
                (255, 0, 255),
                (0, 255, 255),
                (255, 255, 255),
            ][color - 8]
    elif color < 232:
        # 6x6x6 color cube
        r = (color - 16) // 36
        g = ((color - 16) % 36) // 6
        b = (color - 16) % 6
        r, g, b = (
            [0, 95, 135, 175, 215, 255][r],
            [0, 95, 135, 175, 215, 255][g],
            [0, 95, 135, 175, 215, 255][b],
        )
    else:
        # Grayscale ramp
        v = (color - 232) * 10 + 8
        r = g = b = v

    fg_color = get_contrasting_color(r, g, b)
    return f"[{fg_color} on rgb({r},{g},{b})]  {color:3d}  [/]"


def print_color_group(start, end, title):
    swatches = [color_swatch(i) for i in range(start, end + 1)]
    console.print(Panel(Columns(swatches, equal=True, expand=True), title=title))


# Print standard colors (0-15)
print_color_group(0, 15, "Standard colors (0-15)")

# Print color cube (16-231)
print_color_group(16, 231, "Color cube (16-231)")

# Print grayscale (232-255)
print_color_group(232, 255, "Grayscale (232-255)")
