# CodeCaser

A simple Ruby command line utility that converts files from camelCase to snake_case and vice-versa.

## Installation

To install:

    $ gem install code_caser

## Usage

    $ code_caser
    Commands:
      code_caser help [COMMAND]        # Describe available commands or one specific command
      code_caser to_camel --path=PATH  # converts ALL files in PATH from snake_case to camelCase.
      code_caser to_snake --path=PATH  # converts ALL files in PATH from camelCase to snake_case.

To convert a file, pass in the path to the file:

    $ code_caser to_camel --path=/path/to/example_file.js

Passing a folder will convert all files in that folder (non-recursive):

    $ code_caser to_camel --path=/path/to/example_folder

code_caser will happily convert files in any directory with the required permissions, so **exercise caution when using this option!**

By default, copies of each original file will be saved in the same directory as the original, with a timestamp in the filename.  You can prevent this via the --save option:

    # No backup copies will be created:
    $ code_caser to_camel --path=/path/to/example_folder --save=false
