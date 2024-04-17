# nkjob

This script is a tool for creating Nuke templates.

Functions:
- generate_regex(input_text): Generates a regex based on the input text.
- create(source_template, settings, path): Creates a Nuke template.
- main(): The main function of the script.

The script accepts the following command line arguments:
- --project: The path to the video file. This argument is required.
- --shot: A list of shots.
- --prefix_os: The prefix OS. The default is "/home/rszulinski/git/nkjob/PROD/dev".
- --suffix_nuke: The suffix Nuke. The default is "software/nuke/Scenes".
- --suffix_footage: The suffix Footage. The default is "edit/footage/".
- --template_file: The template file. The default is "template.nk".
- --shotlist: The shotlist. The default is "shotlist.csv".
- --asset: The asset. The default is "".
- --log_level: The log level. The default is 'INFO'.

The script logs debug messages for each step of the process, including the generation of the regex, the processing of each entry, and the creation of the Nuke template.
