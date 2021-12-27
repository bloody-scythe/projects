#!/usr/bin/python3
from subprocess import Popen,PIPE,call
from sys import argv
from time import sleep

def getwindowid():
    """Gets the window id of currenty focused window"""
    f = Popen('xdotool getwindowfocus', shell=True,stdout=PIPE)
    id = f.stdout.read().decode().rstrip()
    return int(id)

def autoclick(time=0.6, button=1, window=getwindowid()):
    while True:
        call(('xdotool click --window ', str(window), str(button)))
        sleep(time)

if __name__ == "__main":
    autoclick()
