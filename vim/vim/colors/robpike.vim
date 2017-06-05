" Vim color scheme
"
" This file was generated automatically.
"
" Name: robpike.vim
" Maintainer: Mateusz Piotrowski

set background=light
hi clear
if (exists('syntax_on'))
    syntax reset
endif

let g:colors_name = 'robpike'

hi Normal NONE
hi CursorLine cterm=underline term=underline
hi CursorLineNr ctermfg=NONE guifg=NONE ctermbg=NONE guibg=NONE cterm=bold term=bold
hi ColorColumn ctermbg=254 guibg=#e4e4e4
hi Folded ctermbg=NONE guibg=NONE
hi LineNr ctermfg=7
hi Comment ctermfg=243 guifg=#737373
hi! link Constant Normal
hi! link String Normal
hi! link Identifier Normal
hi! link Statement Normal
hi! link PreProc Normal
hi! link Type Normal
hi! link Special Normal
hi MatchParen ctermfg=4 ctermbg=NONE guibg=NONE
hi Error ctermfg=1 ctermbg=NONE guibg=NONE
hi Search ctermfg=13 ctermbg=NONE guibg=NONE
hi Visual ctermbg=11
hi Title ctermfg=NONE guifg=NONE ctermbg=NONE guibg=NONE cterm=bold term=bold
hi Todo ctermfg=NONE guifg=NONE ctermbg=NONE guibg=NONE cterm=bold term=bold
hi Pmenu ctermfg=16 guifg=Black ctermbg=254 guibg=#e4e4e4
hi PmenuSel ctermfg=231 guifg=#ffffff ctermbg=4
hi TabLineFill ctermbg=15 cterm=NONE term=NONE
hi TabLineSel cterm=bold term=bold
