" Put a note in "" register using path to % file
command! RefNote let @" = "см. [заметку](" . expand('%:p') . ")"

" Use URL from clipboard to paste commit reference after cursor.
command! RefCommit let @" = "([commit](" . @+ . "))" | normal! p

" Format all 'watson log' command output blocks present inside current buffer
command! -nargs=* WatsonLogShort call WatsonLogShortFunc(<f-args>)
