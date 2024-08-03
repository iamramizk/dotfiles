import csv
from rich.console import Console
from rich.table import Table
import sys


def print_csv(file_path):
    console = Console()

    # Read the CSV file
    with open(file_path, mode="r") as file:
        reader = csv.reader(file)
        data = list(reader)

    # Get headers
    headers = data[0]

    # Create a table
    table = Table()
    table.add_column("Index", justify="right", style="cyan", no_wrap=True)
    for header in headers:
        table.add_column(header)

    for i, row in enumerate(data[1:], 1):
        table.add_row(str(i), *row)

    # Print the table
    console.print(table)


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python program.py <file_path>")
        sys.exit(1)
    file_path = sys.argv[1]
    print_csv(file_path)
