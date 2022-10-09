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
    let expr_edit_watson_log = 's#.*\(..:..\) to \(..:..\) *\([0-9].*[0-9]s\).*\(\[.*\)$#* \1-\2 (\3) \4#g'
    if no_args
        execute(':%' . expr_edit_watson_log)
    else
        let string_ranges = a:000
        for range in string_ranges
            execute(':' . range . expr_edit_watson_log)
        endfor
    endif
endfunction


function! WatsonLogRemarksFunc(...)
    let no_args = (a:0 == 0)
    let expr_edit_watson_log = 's#.*\(..:..\) to \(..:..\) *\([0-9].*[0-9]s\).*\(\[.*\)$#\="* ".submatch(1)."-".submatch(2)." (".submatch(3).") ".submatch(4)."\r\r  Сделано:\r  - ...\r  "#g'
    if no_args
        execute(':%' . expr_edit_watson_log)
    else
        let string_ranges = a:000
        for range in string_ranges
            execute(':' . range . expr_edit_watson_log)
        endfor
    endif
endfunction


function! WatsonLogCommitsFunc(...)
    let no_args = (a:0 == 0)
    let expr_edit_watson_log = 's#.*\(..:..\) to \(..:..\) *\([0-9].*[0-9]s\).*\(\[.*\)$#\="* ".submatch(1)."-".submatch(2)." (".submatch(3).") ".submatch(4)."\r\r  Сделано:\r  - ...\r  ".repeat("-",(strchars("* ".submatch(1)."-".submatch(2)." (".submatch(3).") ".submatch(4)) - 2))."\r\r  Коммиты ...\r"#g'
    if no_args
        execute(':%' . expr_edit_watson_log)
    else
        let string_ranges = a:000
        for range in string_ranges
            execute(':' . range . expr_edit_watson_log)
        endfor
    endif
endfunction
