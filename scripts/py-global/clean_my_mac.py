import subprocess
from reprint import output
import os
from pathlib import Path
from rich.console import Console

HOME_PATH = str(Path.home())

CYAN = "\033[36m"
GREEN = "\033[32m"
ORANGE = "\033[38;5;214m"
BOLD = "\033[1m"
RESET = "\033[0m"

LOG = list()

paths_to_clear = [
    f"{HOME_PATH}/Library/Caches",
    f"{HOME_PATH}/Library/Logs",
    f"{HOME_PATH}/Library/Application Support/CrashReporter",
    "/Library/Caches",
    "/System/Library/Caches",
    "/private/var/folders",
]


def clear_directory(directory_path: str):
    """Clears a given directory"""
    # Check if the directory exists
    if os.path.exists(directory_path) and os.path.isdir(directory_path):
        try:
            subprocess.run(["rm", "-rf", os.path.join(directory_path, "*")], check=True)
        except Exception as e:
            LOG.append(e)


def get_directory_size_in_mb(directory: str) -> float:
    total_size = 0
    for dirpath, dirnames, filenames in os.walk(directory):
        for file in filenames:
            file_path = os.path.join(dirpath, file)
            if os.path.isfile(file_path):
                total_size += os.path.getsize(file_path)
    # Convert bytes to megabytes
    size_in_mb = total_size / (1024 * 1024)
    return size_in_mb


def format_size(size: float) -> str:
    """Adds formatting and ensures 8 chars long"""
    formatted_size = f"{size:,.1f}MB"
    return f"{formatted_size:>12}"


def get_log_line(
    status: str = "wait",
    path: str = "/",
    size: int = 0,
    is_total=False,
    is_blank=False,
    color=BOLD,
):
    """Formats the print line for status update"""
    if is_total:
        return f"        \t{color}{format_size(size)}{RESET}\t\t{path}"
        # return f"[ {color}{status.upper()}{RESET} ]\t{color}{format_size(size)}{RESET}\t\t{path}"
    elif is_blank:
        return " "
    return f"[ {color}{status.upper()}{RESET} ]\t{format_size(size)}\t\t{path}"


def main():
    tasks = (
        [
            get_log_line(status="wait", path=path, size=0, color=ORANGE)
            for path in paths_to_clear
        ]
        + [get_log_line(is_blank=True)]
        + [get_log_line(status="wait", path="Total", size=0, color=BOLD, is_total=True)]
    )

    total_cleared = 0
    dir_sizes = {k: "" for k in paths_to_clear}  # stores sizes to avoid resizing

    # Initialize the output with the task list
    with output(output_type="list", initial_len=len(tasks)) as output_lines:
        print()
        for i, task in enumerate(tasks):
            output_lines[i] = task  # Initialize lines

        # Update sizes for all directories first
        for idx, path in enumerate(paths_to_clear):
            size = get_directory_size_in_mb(path)
            dir_sizes[path] = size
            total_cleared += size

            output_lines[idx] = get_log_line(
                status="wait", size=size, path=path, color=ORANGE
            )
            output_lines[-1] = get_log_line(
                is_total=True,
                status="wait",
                size=total_cleared,
                path="Total to be cleared",
                color=ORANGE,
            )

        # Clear the directories
        for idx, path in enumerate(paths_to_clear):
            clear_directory(path)
            size = dir_sizes[path]
            output_lines[idx] = get_log_line(
                status="done", size=size, path=path, color=GREEN
            )

        output_lines[-1] = get_log_line(
            is_total=True,
            status="done",
            size=total_cleared,
            path="Total cleared",
            color=BOLD,
        )


if __name__ == "__main__":
    console = Console()
    main()

    # console.print(LOG)
