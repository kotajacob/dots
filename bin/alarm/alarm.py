#!/usr/bin/env python3
"""
Alarm

========================================
oooo    oooo               .
`888   .8P'              .o8
 888  d8'     .ooooo.  .o888oo  .oooo.
 88888[      d88' `88b   888   `P  )88b
 888`88b.    888   888   888    .oP"888
 888  `88b.  888   888   888 . d8(  888
o888o  o888o `Y8bod8P'   "888" `Y888""8o
               @nilsu.org
=== Copyright (C) 2017  Dakota Walsh ===
"""
import os
import sys
import subprocess
import argparse

ROOT_DIR = os.path.dirname(os.path.abspath(__file__))
MUSIC_FILE = os.path.join(ROOT_DIR, "alarm.opus")

def getArgs():
    # get the passed arguments
    description = "alarm"
    arg = argparse.ArgumentParser(description=description)

    arg.add_argument("-t",
            help="Amount of time for alarm")

    return arg.parse_args()

def main():
    # main function for alarm

    # collect arguments
    arguments = getArgs()

    # check for time and set it to a variable
    if arguments.t:
        time = arguments.t
    else:
        sys.exit("A time must be passed in with t")

    # run sleep for the amount of time needed
    print("alarm set for " + time)
    subprocess.run(["sleep", time])

    # play music
    print("AWAKEN FOUL BEAST")
    subprocess.run(["cvlc", "-R", MUSIC_FILE])

if __name__ == '__main__':
    main()
