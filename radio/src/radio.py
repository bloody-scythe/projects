#!/usr/bin/python3
from shutil import which

mpv = which('mpv')
ytdl = which('yt-dlp') or which('youtube-dl')

if not mpv: raise Exception('Cannot find mpv! Please add it to path.')
if not ytdl: raise Exception('Cannot find youtube-dl, install it or preferably the yt-dlp fork')


def name_to_url(_name, radio_list):
    for radio in radio_list:
        if radio['name'] == _name:
            return radio['url']
    raise Exception('Radio name not found')

def name_list(radio_list):
    names = []
    for radio in radio_list:
        names.append(radio['name'])
    names = "\n".join(names)
    return names
