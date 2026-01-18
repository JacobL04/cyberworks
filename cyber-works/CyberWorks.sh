#!/bin/sh
printf '\033c\033]0;%s\a' CyberWorks
base_path="$(dirname "$(realpath "$0")")"
"$base_path/CyberWorks.x86_64" "$@"
