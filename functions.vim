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


function! WatsonLogShortFunc(...)
    let no_args = (a:0 == 0)
    let expr_edit_watson_log = 's#.*\(..:..\) to \(..:..\) *\(.*h.*m.*s\).*\(\[.*\)$#* \1-\2 (\3) \4#g'
    if no_args
        execute(':%' . expr_edit_watson_log)
    else
        let string_ranges = a:000
        for range in string_ranges
            execute(':' . range . expr_edit_watson_log)
        endfor
    endif
endfunction
