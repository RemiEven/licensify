# licensify

> Bash script inserting license headers to source files

If you have started a project and now want to license it, chances are that you do not want to manually add the header of the license to each file of your project.
This scripts intends to help you through this task, by recursively adding the headers to all source files of your project (or only to the one you specified).

### What this script does

Adding customizable headers using templates and options inside the script.

The currently implemented options are :

* author, year, project name
* type of source files to modify
* type of comment to use (C-style by default : /\* \*/)
* license template (gpl3 header by default)

### What this script does *not*

Update or remove headers

### Usage

To use this script, place it in your project root directory. Then change the various options inside it to fit your needs.

Then, you have two choices :

* I want to add headers to all the files with extension `.ext` inside my project :

```bash
./licensify
```

* I want to add headers only to some of the files of my project :

```bash
./licensify [path_to_file1] [path_to_file2] ...
```

In this case, the modifiable variable `ext` of the script will be ignored.

You are strongly advised to use a version control system before executing this script inside your project.
