" Put a note in "" register using path to % file
command RefNote let @" = "см. [заметку](" . expand('%:p') . ")"

" Use URL from clipboard to paste commit reference after cursor.
command! RefCommit let @" = "([commit](" . @+ . "))" | normal! p
