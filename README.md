## About The Project
This script can convert timestamp `1718328678000` to date `14/6/2024 8:31:18 GMT+7`, and display date with a tooltip

If you find yourself often working with timestamp and need to know what time is that, this script is for you

![Ez_timestamp Screen Shot](/image/Ez_timestamp%20showcase.png)

## Installation
1. Install AutoHotKey from [https://www.autohotkey.com](https://www.autohotkey.com) (v2 is required)
2. Double click `Ez_timestamp_viewer.ahk` to run script. You can see a Green H icon in System tray indicate that script is running
3. (Optional) Put `Ez_timestamp_viewer.ahk` in startup folder, then script will auto run on window startup

   Oh! Just in case, in order to open startup folder quickly, press `Window + R`, then enter `shell:startup`
   
## Usage
- Copy **millisecond timestamp** or **second timestamp** to trigger script.

- `Ctrl + F1` to Exit. You can also exit script at tray icon

- <code>Ctrl + `</code> to toggle script

## Customize script
The default script's timezone is +7. You should change timezone to match your

Edit line 7 of script to your timezone

```global time_zone_GMT := 7```


















