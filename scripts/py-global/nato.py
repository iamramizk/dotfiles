import sys
from rich.console import Console

# NATO phonetic alphabet dictionary
nato_phonetic = {
    "A": "Alpha",
    "B": "Bravo",
    "C": "Charlie",
    "D": "Delta",
    "E": "Echo",
    "F": "Foxtrot",
    "G": "Golf",
    "H": "Hotel",
    "I": "India",
    "J": "Juliett",
    "K": "Kilo",
    "L": "Lima",
    "M": "Mike",
    "N": "November",
    "O": "Oscar",
    "P": "Papa",
    "Q": "Quebec",
    "R": "Romeo",
    "S": "Sierra",
    "T": "Tango",
    "U": "Uniform",
    "V": "Victor",
    "W": "Whiskey",
    "X": "X-ray",
    "Y": "Yankee",
    "Z": "Zulu",
}


def get_query() -> list:
    """Gets sys arv query, else all alphabet"""

    if len(sys.argv) < 2:
        return nato_phonetic.keys()
    return " ".join([a.upper() for a in sys.argv[1:]])


def line_format(char, idx_color, accent_color) -> str:
    """Formats line with color coding"""

    char = char.upper()
    if char in nato_phonetic:
        phonetic = nato_phonetic[char]
        return f"[{idx_color}] {char}[/{idx_color}]  [{accent_color}]{phonetic}[/{accent_color}]"
    return f"[{idx_color}] {char}[/{idx_color}]"


def print_table(query: str) -> None:
    """Prints table based on query input"""

    IDX_COLOR = "#C7C7C7"
    COLOR_1 = "#53D5BE"
    COLOR_2 = "#008E7D"

    print()
    for idx, char in enumerate(query):
        if idx % 2 == 0:
            console.print(line_format(char, IDX_COLOR, COLOR_1))
        else:
            console.print(line_format(char, IDX_COLOR, COLOR_2))
    print()


if __name__ == "__main__":
    console = Console()
    query = get_query()
    print_table(query)
