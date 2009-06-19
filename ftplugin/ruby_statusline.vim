if exists("b:did_ruby_statusline_ftplugin")
    finish
endif
let b:did_ruby_statusline_ftplugin = 1

let &statusline = substitute(&statusline, '\(%=\)', '%{StatuslineRubySyntaxCheck()}\1', '')

"recalculate after saving
autocmd bufwritepost * unlet! b:statusline_ruby_syntax_check

function! StatuslineRubySyntaxCheck()
    if !exists("b:statusline_ruby_syntax_check")
        call system("ruby -c " . expand("%"))
        if v:shell_error != 0
            let b:statusline_ruby_syntax_check = '[invalid-syntax]'
        else
            let b:statusline_ruby_syntax_check = ''
        endif
    endif
    return b:statusline_ruby_syntax_check
endfunction
