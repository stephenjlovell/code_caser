# CodeCaser

A simple Ruby command line utility that converts files from camelCase to snake_case and vice-versa.

## Installation

To install:
```
$ gem install code_caser
```
## Usage
```
$ code_caser
Commands:
  code_caser help [COMMAND]        # Describe available commands or one specific command
  code_caser to_camel --path=PATH  # converts files in PATH from snake_case to camelCase.
  code_caser to_snake --path=PATH  # converts files in PATH from camelCase to snake_case.
```
To use, pass in the path to the file or folder:
```
$ code_caser to_camel --path=/path/to/example_file.js
```
Passing a folder will convert all files in that folder (non-recursive):
```
$ code_caser to_camel --path=/path/to/example_folder
```
code_caser will happily convert files in any directory with the required permissions, so **exercise caution when passing in a directory!** You will be presented a confirmation dialog before any files are converted.

You may also pass in a globbed directory to convert only files that match a given pattern:
```
$ code_caser to_camel --path/to/example_folder/*.js
```
## Options
Use the ```--verbose``` flag to print any changes made to each file to the terminal.

By default, backup copies of each file converted will be saved to a timestamped backup folder in the ```--path``` directory. You can prevent backups from being created by passing in the ```--no-save``` flag.
