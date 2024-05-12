# screen_ppi_getter

A Flutter plugin for a simple task - retrieve PPI of a display.
There is currently no way to do this using Flutter standard library and
that is why this package was born

## Android

To get PPI on Android, this plugin exposes `android.util.DisplayMetrics.densityDpi`
public property. Please see `https://developer.android.com/reference/android/util/DisplayMetrics`
to learn more

## iOS

There is currently no way to get PPI of iOS device using Flutter or Swift or Objective-C or
whatever. However, since Apple devices list is determined and rarely changes (i.e. new
device is released), this library stores the table of all iPhone devices and retrieves
PPI based on current device (see `Tools` section)

## Tools

You may explore `tools` directory, which contains tools required for generating data

### ios_devices_parser

`ios_devices_parser` is a tool used to parse iOS devices from table provided at https://www.ios-resolution.com

To use this tool, follow these steps:

- Change directory to `tools/ios_devices_parser` with `cd tools/ios_devices_parser`
- Initialize and activate an empty Python virtual environment with `python -m venv venv && source venv/bin/activate`
- Install Python dependencies with `pip install -r requirements.txt`
- Run script using `python ios_devices_parser.py`
- Generated JSON file should be placed in `generated` directory

## TODO

- [ ] Native Android code testing
- [ ] Example project testing
- [ ] Automated testing and deployment