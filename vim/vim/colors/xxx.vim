" Vim color scheme
"
" This file is generated, please check bin/generate.rb.
"
" Name:       xxx.vim
" Maintainer: Mateusz Piotrowski <mpp302@gmail.com>
" License:    MIT

set background=dark

hi clear
if exists('syntax_on')
   syntax reset
endif

let g:colors_name = 'xxx'

" These commands are generated, see bin/generate.rb.
hi Normal guifg=White ctermfg=15 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE term=NONE
hi Cursor guifg=Yellow ctermfg=226 guibg=#778899 ctermbg=67 gui=NONE cterm=NONE term=NONE
hi CursorLine guifg=NONE ctermfg=NONE guibg=#202020 ctermbg=234 gui=NONE cterm=NONE term=NONE
hi CursorLineNr guifg=NONE ctermfg=NONE guibg=NONE ctermbg=NONE gui=bold cterm=bold term=bold
hi ColorColumn guifg=NONE ctermfg=NONE guibg=#202020 ctermbg=234 gui=NONE cterm=NONE term=NONE
hi FoldColumn guifg=DarkGray ctermfg=248 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE term=NONE
hi Folded guifg=NONE ctermfg=NONE guibg=NONE ctermbg=NONE gui=NONE cterm=NONE term=NONE
hi LineNr guifg=DarkGray ctermfg=248 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE term=NONE
hi Comment guifg=#737373 ctermfg=243 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE term=NONE
hi Constant guifg=White ctermfg=15 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE term=NONE
hi String guifg=Yellow ctermfg=226 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE term=NONE
hi Identifier guifg=White ctermfg=15 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE term=NONE
hi Statement guifg=White ctermfg=15 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE term=NONE
hi PreProc guifg=White ctermfg=15 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE term=NONE
hi Type guifg=White ctermfg=15 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE term=NONE
hi Special guifg=White ctermfg=15 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE term=NONE
hi MatchParen guifg=Black ctermfg=16 guibg=#737373 ctermbg=243 gui=NONE cterm=NONE term=NONE
hi pythonEscape guifg=Yellow ctermfg=226 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE term=NONE
hi Search guifg=White ctermfg=15 guibg=#778899 ctermbg=67 gui=NONE cterm=NONE term=NONE
hi Visual guifg=White ctermfg=15 guibg=#778899 ctermbg=67 gui=NONE cterm=NONE term=NONE
hi Title guifg=White ctermfg=15 guibg=NONE ctermbg=NONE gui=bold cterm=bold term=bold
hi markdownHeadingDelimiter guifg=White ctermfg=15 guibg=NONE ctermbg=NONE gui=bold cterm=bold term=bold
hi markdownHeadingRule guifg=White ctermfg=15 guibg=NONE ctermbg=NONE gui=bold cterm=bold term=bold
hi markdownLinkText guifg=Yellow ctermfg=226 guibg=NONE ctermbg=NONE gui=underline cterm=underline term=underline
hi Todo guifg=White ctermfg=15 guibg=NONE ctermbg=NONE gui=bold cterm=bold term=bold
hi Pmenu guifg=White ctermfg=15 guibg=#778899 ctermbg=67 gui=NONE cterm=NONE term=NONE
hi PmenuSel guifg=#778899 ctermfg=67 guibg=White ctermbg=15 gui=NONE cterm=NONE term=NONE
