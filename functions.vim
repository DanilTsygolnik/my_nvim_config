function! MakeMdQuote()
    let quote_templ = substitute(@", " ", "-", "g")
    let quote_name = "[^" . tolower(quote_templ) . "]"
    " Write a quote name into the unnamed register
    let @" = quote_name
    " Paste the quote name at cursor position (i.e. replace visual block)
    normal!p
    " Write the full quote into the unnamed register
    let @" = @" . ": " . @+
    " Paste the full quote at the end of the note and jump back to quote name position
    normal! Gop
endfunction
