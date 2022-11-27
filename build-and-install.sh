#!/bin/bash

# Copy systemd service
sudo cp ./fbcp-ili9341.service /etc/systemd/system/fbcp-ili9341.service
sudo systemctl daemon-reload
sudo systemctl enable fbcp-ili9341

# Build
mkdir -p build64
cd build64
cmake .. -DPIMORONI_DISPLAY_HAT_MINI=ON -DSPI_BUS_CLOCK_DIVISOR=8 -DDISPLAY_BREAK_ASPECT_RATIO_WHEN_SCALING=ON -DDISPLAY_CROPPED_INSTEAD_OF_SCALING=OFF -DBACKLIGHT_CONTROL=ON -DDISABLE_BATTERY_SAVER_FEATURES=ON -DSTATISTICS=0 -DAARCH64=YES
make -j
sudo systemctl stop fbcp-ili9341
sudo install ./fbcp-ili9341 /sbin/fbcp-ili9341
sudo systemctl start fbcp-ili9341
cd ..
