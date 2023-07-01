# Correcting Wrong Commit

## Merge Conflict

When there is a merge conflict, you would need to select which version to get, and then you can continue with the regular workflow. 

## Fetch vs Pull

git pull = git fetch + git merge


## Tagging and Forgot to create a feature branch

### Tagging

to tag specific points in the history as being important. it labels and marks a specific commit
Usually for v1.0, etc.

git tag: to list tags
git tag -a v1.0 -m "tagging message": used -a for annotated tag

once you tag, you need to sync it to the remote repository using git push origin

you can go back to that version with: git checkout tags/TAG, which would put you in a detached state, which you can save by checking to a branck or:git checkout tags/TAGS -b branch

### Rename or remove a file tracked by git

git rm and mv to remove or rename a file
git clean -df ro remove untracked file

## Forgot to create a feature branch

In case we made changes to the master branch and we want to move those changes to another branch

we can use git cherry-pick with the number of the commit:
git cherry-pick <number>
we can get the number with git log

## Reset
3 types of reset: 
* soft: keeps changes in staging directory. dont lose any work
* mixed: keeps changes in working directory
* hard: dont keep changes to the files. keep tracked file in the state they were at that commit. untracked files are not affected

git reset --<mode> <commit_hash>

# Basic unix commands for DS

* echo: outputs the text
* cat: concatenate files and print on the standard output
* tac: print in reverse
* grep: print lines matching a pattern
* cut: select part of a line
* tr: translate, squeeze, and/or delete characters
* head: print lines from the start of the file
* tail: opposite of head
* more_ paging through mtext one screenful at a time
* sort: sort lines
* uniq: report or omit repeated lines
* curl: tool to transfer data from or to server

# Regular expressions (regex)

a pattern of text used by other programs like grep, sed, awk and others to filter the input text

^ = beginning of line
($) = end of line
. = matches any character except newline
* = preceding character must match zero or more time
[characters] = matches any character in the set
- = specifies a range, for example [a-f]
the reverse for matching is [^a-z]. This would negate the set, but it must not be at the beginning of the filter.
? = previous character may exist or not
+ = previous character must exist at least once
[[:word:]] = or \w word characters

## Special characters

[[:alpha:]] : any alphabetical character
lower: a-z lower case
digit: 0-9
alnum: 0-9, A-Z, a-z
punct: any punctuation character
blank: space or tab only

## Grouping expresions

Using brackets () would be considered one character, so this would make it easier to use in a filter. 

# AWK

It works on records.
If record separator is newline, then each line is a record. 

* RS: record separator. awk process input stream a record at a time. default is newline
* NR: current input record number. if newline is delimitor, then it is current line number
* FS/OFS: awk splits a record using FS into different fields. When printing a record it joins the field using OFS. Usually FS/OFS are the same with default value whitespace
* NF: number of fields in the current record

$0: stores whole record
$1: stores first field
$2 stores second record and so on

# SED

sed = stream editor
used for search and replace

example: sed "s/colour/color/" would replace colour for color. but this would only replace the first instance.
to replace every instance, we would use /g at the end, which means global

s = search and replace
p = print
d = delete
i = insert
a = append