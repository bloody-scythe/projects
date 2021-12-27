#!/usr/bin/python3
import json, radio,fzf
from time import sleep
from subprocess import Popen

if __name__ == '__main__':
    radio_list = "/home/vitorjl/projects/radio/radios/list.json"

    with open(radio_list) as f:
        radios = json.loads(f.read())
    names = radio.name_list(radios)

    while True:
        name = fzf.select(names)
        try:
            url = radio.name_to_url(name,radios)
            proc =  Popen(['mpv','--no-video', url])
            proc.wait()
        except:
            break

