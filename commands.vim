" Put a note in "" register using path to % file
command RefNote let @" = "см. [заметку](" . expand('%:p') . ")"

" Paste a commit reference as md hyperlink at cursor position.
command! -nargs=? RefCommit let @" = GetCommitRef(<f-args>) | normal! p
