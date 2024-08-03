import random
import string
import pyperclip
from rich.console import Console

console = Console()


def generate_password(length=12):
    """Generate a strong password with the given length."""
    letters = string.ascii_letters
    digits = string.digits
    special_chars = string.punctuation

    # Ensure the password has at least one of each type of character
    password = [
        random.choice(letters),
        random.choice(letters.upper()),
        random.choice(digits),
        random.choice(special_chars),
    ]

    # Fill the rest of the password length with random characters
    password.extend(
        random.choice(letters + letters.upper() + digits + special_chars)
        for _ in range(length - 4)
    )

    # Shuffle the password to make it more random
    random.shuffle(password)

    return "".join(password)


if __name__ == "__main__":
    length = 16  # Choose your desired password length
    password = generate_password(length)
    pyperclip.copy(password)

    console.print(
        f"\n[bold cyan]>[/bold cyan] Copied to clipboard: [bold white]{password}[/bold white]"
    )
