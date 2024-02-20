# nkjob

This Python script is a utility for creating .nk files in a specific directory structure. It's designed to work with a specific workflow, where files are organized in a certain way and need to be processed according to certain rules. Here's a breakdown of what the script does:

1. It sets up a logger to log information and errors.

2. It defines several helper functions:
   - `generate_regex(input_text)`: Generates a regular expression based on the input text.
   - `edit_nk_files(nk_file, kwargs)`: Edits a .nk file, replacing certain strings with others.
   - `rename_file(src, des)`: Renames a file from `src` to `des`.
   - `copy_file(source_file, destination_path)`: Copies a file from `source_file` to `destination_path`.
   - `get_env_var(var_name)`: Gets the value of an environment variable.
   - `get_first_and_last_file(directory, filename)`: Gets the first and last file in a directory that match a certain filename pattern.
   - `count_files(url, extension)`: Counts the number of files in a directory and its subdirectories that have a certain extension.
   - `create(prefix, match, filename, source_file, url, extension, user_input, settings)`: Creates a new directory and file structure based on certain parameters.

3. It defines a `main(settings)` function that:
   - Prompts the user for input.
   - Checks if a template file exists.
   - Constructs a URL based on the user input.
   - Checks if the URL exists and there are files in the directory.
   - Reads data from a shot list file and processes each entry.

4. It runs the `main(settings)` function if the script is run as a standalone program.

The script is designed to be run from the command line and interacts with the user through standard input and output. It also can use environment variables to get certain settings when user is set to specific job. 