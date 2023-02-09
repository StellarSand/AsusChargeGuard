#!/usr/bin/env bash

# Copyright (c) 2023 the-weird-aquarian

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Show usage
usage() {

cat << EOF

Usage:
sudo acg <threshold>

Description:
Download the latest ISO images for various GNU/Linux distributions directly from the terminal.

Available options:
 -h,  --help            Show this help message
 -p,  --profile         Show profiles list

Examples:
sudo acg balanced
sudo acg 60

NOTE:
It is recommended to use built in profiles (full, balanced, maxlife).
Custom thresholds are supported, however they will only work if it's supported
by the laptop itself.

EOF

}

hasChargeLimitSupport() {
if ! (ls "$charge_threshold_file" > /dev/null)
then
  echo -e "\nLaptop doesn't support limiting battery charge level.\n"
  exit 1
fi
}

bat_name=$(echo /sys/class/power_supply/BAT* | sed 's/.*supply\///')
charge_threshold_file="/sys/class/power_supply/${bat_name}/charge_control_end_threshold"
service_file="/etc/systemd/system/AsusChargeGuard.service"
limit=80

hasChargeLimitSupport

if [ $# -eq 0 ]
then
  usage
  exit 0
fi

while [ $# -gt 0 ]
do
  case "$1" in

    -h | --help)
      usage
      exit 0
    ;;

    -p | --profile)
      echo -e "\nAvailable profiles:\n"
      echo -e "full (100)\nbalanced (80)\nmaxlife (60)\n"
      exit 0
    ;;

    -*)
      echo -e "\nInvalid option: $1"
      echo -e "Try 'acg -h' for more info.\n"
      exit 1
    ;;

    *)
      if [ "$1" == "full" ]
      then
        limit=100
      elif [ "$1" == "balanced" ]
      then
        limit=80
      elif [ "$1" == "maxlife" ]
      then
        limit=60
      elif [ "$1" -ge 1 ] && [ "$1" -le 100 ]
      then
        limit="$1"
      else
        echo -e "\nNot a valid threshold."
        echo "Either use built in profiles"
        echo -e "or enter a valid threshold between 1-100.\n"
        echo -e "Try 'acg -h' for more info.\n"
        exit 1
      fi
      shift
    ;;

  esac
done

sudo sed -i "s|Exec.*|ExecStart=/bin/bash -c 'echo $limit > $charge_threshold_file'|" "$service_file"
sudo systemctl restart asus-charge-guard.service

exit 0
