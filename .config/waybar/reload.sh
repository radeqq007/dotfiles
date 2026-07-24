#!/bin/bash

pkill waybar && waybar >/dev/null 2>&1 & disown
