#!/bin/sh
# Flash ESP32-DATV (experimental ESP32-S3 build) through the board's native USB port.
# Usage: ./flash.sh /dev/ttyACM0      (needs: python3 -m pip install esptool)
set -e
PORT=${1:-/dev/ttyACM0}
cd "$(dirname "$0")"
python3 -m esptool --chip esp32s3 -p "$PORT" -b 460800 --before default-reset --after hard-reset \
    write-flash --flash-mode dio --flash-size 4MB --flash-freq 80m \
    0x0 bootloader.bin 0x8000 partition-table.bin 0x10000 esp32_datv.bin
