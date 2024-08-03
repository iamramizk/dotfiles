import pyperclip
from rich.console import Console

console = Console()

pyperclip.copy("")
console.print(f"\n[bold cyan]>[/bold cyan] Clipboard cleared")
