# licensify

> Bash script inserting license headers to source files

If you have started a project and now want to license it, chances are that you do not want to manually add the header of the license to each file of your project.
This scripts intends to help you through this task, by recursively adding the headers to all source files of your project.

### What this script does

Adding customizable headers using templates and options inside the script.

The currently implemented options are :

* author, year, project name
* type of source files to modify
* type of comment to use (C-style by default : /* */)
* license template (gpl3 header by default)

### What this script does *not*

Update or remove headers

To use this script, place it in your project root directory. Then change the various options inside it to fit your needs. Finally, you can simply run it, no line command options are required.
You are strongly advised to use a version control system before executing this script inside your project.
