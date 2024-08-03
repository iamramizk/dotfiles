import os
import sys
import time
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
from subprocess import Popen, PIPE

# Set the path to the directory you want to watch
path = os.getcwd()  # Watch the current working directory

# Set the port for the server
port = 8000

# Set the command to start the server
server_command = f"python3 -m http.server {port}"

# Set the command to stop the server
stop_server_command = "echo 'Stopping server...'"

# Flag to track if the server is running
server_running = False


def start_server():
    global server_running
    if not server_running:
        print("Starting server...")
        global server_process
        server_process = Popen(server_command.split(), stdout=PIPE, stderr=PIPE)
        server_running = True


def stop_server():
    global server_running
    if server_running:
        print("Stopping server...")
        server_process.terminate()
        server_running = False


class MyHandler(FileSystemEventHandler):
    def on_any_event(self, event):
        if event.is_directory:
            return
        elif event.event_type == "modified":
            print(f"Detected change in {event.src_path}")
            stop_server()
            start_server()


if __name__ == "__main__":
    event_handler = MyHandler()
    observer = Observer()
    observer.schedule(event_handler, path=path, recursive=True)
    observer.start()
    try:
        start_server()
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()
