# To contribute please follow these rules

## What can I do?

To determine what you could help with, you can:

- Open an issue if you have an idea for improvement.
- Check in the Issues if anything needs to be fixed.
- Are you a beginner? Search for issues with the 'Beginner friendly' label!

## Name your branch

According to the type of submission you are planning to make, create a branch called:

- Feature: "Feature_<Description>"
- BugFix: "BugFix_<Description>"
- Minor: "Minor_<Description>"

## Development

Functions and classes should be written in a seperate files.

> Exceptions to this rule apply. Sometimes it makes more sense to group things by 'theme' (e.g. the charts classes and functions). That is also OK. The thing to keep in mind is **not** to write your code directly in the `pshtml.psm1` file.


### Functions

Functions need to go in `Code\Functions\Public\$FunctionName.ps1` Or `Code\Functions\Private\$FunctionName.ps1` for private functions.

### Classes

Classes should be located in `Code\Classes\$ClassName.ps1`

## Building the module

Once the developement is done, you need to build the module by calling `CI\03_Build.ps1` file. It will generate the `pshtml.psm1` and the `pshtml.psd1` 

All the files that have been generated (`pshtml.ps1` and `pshtml.psd1`) and the developement file that are part of you PR

## When creating a Pull Request (PR) be sure to

1. Have added comment
2. If it is a new feature / cmdlet, some help (comment based help will suffice in most cases)
3. One or two examples on how to use it
