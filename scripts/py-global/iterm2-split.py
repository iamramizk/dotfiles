#!/usr/bin/env python3
import iterm2
import asyncio

async def split_and_run_commands(connection, left_command=None, right_command=None):
    app = await iterm2.async_get_app(connection)
    window = app.current_terminal_window
    if window is None:
        print("No current iTerm2 window found")
        return

    tab = window.current_tab
    if tab is None:
        print("No current tab found")
        return

    left_pane = tab.current_session
    right_pane = await left_pane.async_split_pane(vertical=True)

    if left_command:
        await left_pane.async_send_text(left_command + "\n")
    if right_command:
        await right_pane.async_send_text(right_command + "\n")

async def main(connection):
    await split_and_run_commands(connection, 
                                 left_command="echo Left pane running",
                                 right_command="echo Right pane running")

if __name__ == "__main__":
    iterm2.run_until_complete(main)

