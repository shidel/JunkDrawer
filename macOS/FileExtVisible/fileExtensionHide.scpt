#!/usr/bin/osascript

on run argv
tell application "Finder" to set extension hidden of (POSIX file (first item of argv) as alias) to true
end run