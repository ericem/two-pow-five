# cerner_2^5_2019
import osproc
import re
import strutils
import strformat
let (battery, error) = execCmdEx("pmset -g batt")
var on_battery = contains(battery, re"Battery Power")
var on_ac = contains(battery, re"AC Power")
var discharging = contains(battery, re"discharging")
var level_percent = findall(battery, re"(\d+)%")
var level = parseInt(strip(level_percent[0], chars = {'%'}))
if on_battery:
  if level <= 10: #f579
    echo fmt" {level}%"
  if level <= 20:
    echo fmt" {level}%"
  if level <= 30: # f57b
    echo fmt" {level}%"
  if level <= 40: # f57c
    echo fmt" {level}%"
  elif level <= 50:
    echo fmt" {level}%"
  elif level <= 60: # f57e
    echo fmt" {level}%"
  elif level <= 70: # f57f
    echo fmt" {level}%"
  elif level <= 80:
    echo fmt" {level}%"
elif on_ac:
    echo fmt" {level}%"
else:
    echo fmt" {level}%"
