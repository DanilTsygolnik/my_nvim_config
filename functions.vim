" Get a commit reference to paste in md note
function GetCommitRef(...)
    let ref_file_dir = expand('%:p:h')
    let repo_name_templ = system('cd ' .ref_file_dir." && basename -s .git `git config --get remote.origin.url`")
    " get repo name without newline added by Vim
    let repo_name = substitute(repo_name_templ, '\n\+$', '', '')
    let commit_url_templ = "https://github.com/DanilTsygolnik/" . repo_name . "/commit/"
    if a:0 == 0
        " get commit hash at HEAD position without newline added by Vim
        let head_commit_hash = substitute(system('git rev-parse --short HEAD'), '\n\+$', '', '')
    else
        let head_commit_hash = a:1
    endif
    let commit_url = commit_url_templ . head_commit_hash
    let md_style_commit_ref = "см. [коммит](" . commit_url . ")"
    return md_style_commit_ref
endfunction
