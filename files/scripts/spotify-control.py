#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import sys
import dbus
from dbus import Interface

if len(sys.argv) < 1:
    print('No arguments provided!')
    sys.exit(1)

# Some string definitions
spotify_str = 'org.mpris.MediaPlayer2.spotify'
player_str  = 'org.mpris.MediaPlayer2.Player'
prop_str    = 'org.freedesktop.DBus.Properties'

# Get the appropriate dbus objects
bus = dbus.SessionBus()

# See if spotify is running
try:
    spotify = bus.get_object(spotify_str, '/org/mpris/MediaPlayer2')
except:
    print('no spotify')
    sys.exit(0)

player = dbus.Interface(spotify, dbus_interface=player_str)
#print player
properties = dbus.Interface(spotify, dbus_interface=prop_str)

def get_prop(prop):
    return spotify.Get(player_str, prop, dbus_interface='org.freedesktop.DBus.Properties')

action = sys.argv[1]
if action == 'metadata':
    dict = get_prop('Metadata')
    title = dict['xesam:title']
    artist = ', '.join(dict['xesam:artist'])
    print('{} - {}'.format(title, artist))

if action == 'playpause':
    player.PlayPause()

if action == 'stop':
    player.Stop();

if action == 'next':
    player.Next()

if action == 'prev':
    player.Previous()

if action == 'rawmetadata':
    print(get_prop('Metadata'))
