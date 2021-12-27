#!/usr/bin/python3
import subprocess

def select(text):
    if type(text) is not str: text = "\n".join(text)
    """Uses fzf select line from string. Returns the selected line."""
    with subprocess.Popen(["fzf"], stdin=subprocess.PIPE, stdout=subprocess.PIPE) as proc:
        line =  proc.communicate(text.encode())
    return line[0].decode().rstrip()
