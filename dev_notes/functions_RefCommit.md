## Resources

---

[Get the name of the current file](https://vim.fandom.com/wiki/Get_the_name_of_the_current_file):
- `expand('%:p')` - полный путь к файлу;
- `expand('%:p:h')` - директория текущего файла, head;
Примечание: % - регистр, который содержит имя текущего открытого файла.

---

`system('external command')` -- [How to get a value of an external command](https://vim.fandom.com/wiki/Append_output_of_an_external_command#Using_system()).

---

`basename $(git rev-parse --show-toplevel)` -- [How do you get the Git repository's name in some Git repository](https://stackoverflow.com/a/15716016)

---

`git rev-parse --short HEAD` -- [How to get the hash for the current commit in Git](https://stackoverflow.com/a/949391)

---

`substitute(repo_name_templ, '\n\+$', '', '')` -- [Remove trailing newline characters in the end of terminal output](https://vi.stackexchange.com/a/2868)

---

Concatenation in Vim scripts:  [^vimsript-cheatsheet]      
`let long_string = "very" . "long" . "string"`

---

How to capture return value from function in vim:      
`let @" = GetCommitRef()`

---

How to pass multiple args to a custom Vim command:
```vim
# структура команды
command! -nargs=<arg_param> <command_name> <action>

# примеры команд
command! -nargs=* Save call script#foo(<args>)
command! -nargs=? RefCommit let @" = GetCommitRef(<f-args>) | normal! p
```
Arguments parameters:  [^vimsript-cheatsheet]
- `-nargs=0` -- 0 arguments, default;
- `-nargs=1` -- 1 argument, includes spaces;
- `-nargs=?` -- 0 or 1 argument;
- `-nargs=*` -- 0+ arguments, space separated;
- `-nargs=+` -- 1+ arguments, space reparated .

---

Команду `RefCommit` построил с помощью [примеров](https://superuser.com/a/1399163).

---



[^vimsript-cheatsheet]: https://devhints.io/vimscript
