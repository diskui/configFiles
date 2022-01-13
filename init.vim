"----------------------------------------------------------------------------------------------------------------------------------------------------------
"vimplug 插件
call plug#begin('~/.config/nvim/plgged')

"markdown预览
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

"coc自动补全
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"markdown 语法高亮:
"Plug 'plasticboy/vim-markdown'

"纠错
Plug 'dense-analysis/ale'

"nerdtree
Plug 'preservim/nerdtree'

"状态栏插件
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"彩虹括号插件
Plug 'luochen1990/rainbow'

"自动补全括号
Plug 'jiangmiao/auto-pairs'

"indentline
Plug 'Yggdroot/indentLine'

"自动格式化代码
"Plug 'vim-autoformat/vim-autoformat'

" add this line to your .vimrc file
Plug 'mattn/emmet-vim'

call plug#end()

"----------------------------------------------------------------------------------------------------------------------------------------------------------
" Disable completion for markdown and lisp
autocmd FileType markdown let b:coc_suggest_disable = 1
autocmd FileType lisp let b:coc_suggest_disable = 1

"----------------------------------------------------------------------------------------------------------------------------------------------------------


"----------------------------------------------------------------------------------------------------------------------------------------------------------
"映射&键位

"映射tab切换标签页
nnoremap <tab> :tabn<cr>
nnoremap <S-tab> :tabp<cr>

"映射vimrc
nnoremap <S-r> :tabnew $MYVIMRC<cr>

"ctrl + n开启文件树
map <C-n> :NERDTreeToggle<CR>


"映射j与k为gj与gk，在折行内移动
map j gj
map k gk


"----------------------------------------------------------------------------------------------------------------------------------------------------------

"----------------------------------------------------------------------------------------------------------------------------------------------------------
"开启语法高亮以及设置主题
"设置真值颜色
"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
    if (has("nvim"))
        "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif
    "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
    "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
    " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
    if (has("termguicolors"))
        set termguicolors
    endif
endif

"transparent backgroud
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE " transparent bg

set background=dark
syntax enable
colorscheme molokai

"----------------------------------------------------------------------------------------------------------------------------------------------------------

"----------------------------------------------------------------------------------------------------------------------------------------------------------
"airline设置
set laststatus=2  "永远显示状态栏
let g:airline_powerline_fonts = 1  " 支持 powerline 字体
"let g:airline#extensions#tabline#enabled = 1  "显示窗口tab和buffer
let g:airline_theme='deus'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

"let g:airline_left_sep = '»'
let g:airline_left_sep = ''
"let g:airline_right_sep = '«'
let g:airline_right_sep = ''
"let g:airline_symbols.colnr = ' ㏇:'
let g:airline_symbols.colnr = ' :'
let g:airline_symbols.crypt = '🔒'
"let g:airline_symbols.linenr = '☰'
"let g:airline_symbols.linenr = ' ␊:'
"let g:airline_symbols.linenr = ' ␤:'
let g:airline_symbols.linenr = ' '
"let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = ' ㏑'
let g:airline_symbols.branch = ''  "⎇
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
let g:airline_symbols.paste = ''
"let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.spell = ''
"let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.notexists = ''
let g:airline_symbols.whitespace = ''

"----------------------------------------------------------------------------------------------------------------------------------------------------------

"----------------------------------------------------------------------------------------------------------------------------------------------------------
"F5一键编译
func! CompileGcc()
    exec "w"
    let compilecmd="!gcc "
    let compileflag="-o %< "
    if search("mpi\.h") != 0
        let compilecmd = "!mpicc "
    endif
    if search("glut\.h") != 0
        let compileflag .= " -lglut -lGLU -lGL "
    endif
    if search("cv\.h") != 0
        let compileflag .= " -lcv -lhighgui -lcvaux "
    endif
    if search("omp\.h") != 0
        let compileflag .= " -fopenmp "
    endif
    if search("math\.h") != 0
        let compileflag .= " -lm "
    endif
    exec compilecmd." % ".compileflag
endfunc
func! CompileGpp()
    exec "w"
    let compilecmd="!g++ "
    let compileflag="-o %< "
    if search("mpi\.h") != 0
        let compilecmd = "!mpic++ "
    endif
    if search("glut\.h") != 0
        let compileflag .= " -lglut -lGLU -lGL "
    endif
    if search("cv\.h") != 0
        let compileflag .= " -lcv -lhighgui -lcvaux "
    endif
    if search("omp\.h") != 0
        let compileflag .= " -fopenmp "
    endif
    if search("math\.h") != 0
        let compileflag .= " -lm "
    endif
    exec compilecmd." % ".compileflag
endfunc



func! CompileCode()
    exec "w"
    if &filetype == "cpp"
        exec "call CompileGpp()"
    elseif &filetype == "c"
        exec "call CompileGcc()"
        "elseif &filetype == "java"
        "        exec "call CompileJava()"
    endif
endfunc

func! RunPython()
    :term python ./%
endfunc


func! RunResult()
    exec "w"
    if search("mpi\.h") != 0
        exec "!mpirun -np 4 ./%<"
    elseif &filetype == "cpp"
        :term ./%<
    elseif &filetype == "c"
        :term ./%<
    elseif &filetype == "python"
        exec "call RunPython()"
    endif
endfunc

nnoremap <A-c> :call CompileCode()<CR>

nnoremap <A-r> :call RunResult()<CR>


"----------------------------------------------------------------------------------------------------------------------------------------------------------
"杂项
"开启彩虹括号插件
let g:rainbow_active = 1

"设置markdowm preview 的默认浏览器
let g:mkdp_browser = '/usr/bin/firefox'

"terminal模式退出输入
:tnoremap <Esc> <C-\><C-n>

"关闭ale的coc特性
let g:ale_disable_lsp = 1

"开启行号
set nu

"markdown键位映射alt + m
nmap <A-m> :MarkdownPreview <CR>

"将缩进设置为空格
let $t_ut = ' '
set expandtab

"缩进配置为4空格
set tabstop =4
set shiftwidth =4
set softtabstop =4

"关闭提示音
set vb t_vb=

"自动缩进
set autoindent

"设置相对行号
set relativenumber

"airline 光标位置显示
let g:airline_section_z='%l%#__restore__#:%v'

"开启autoformat自动格式化
"au BufWrite * :Autoformat
"autocmd FileType yaml,tex let b:autoformat_autoindent=0
"autocmd FileType python,tex let b:autoformat_autoindent=0
"autocmd FileType conf,tex let b:autoformat_autoindent=0
"autocmd FileType zsh,tex let b:autoformat_autoindent=0
"autocmd FileType markdown,tex let b:autoformat_autoindent=0
"autocmd FileType md,tex let b:autoformat_autoindent=0


"c语言花括号在行尾
"if !exists('g:formatdef_astyle_c')
"    if filereadable('.astylerc')
"        let g:formatdef_astyle_c = '"astyle --mode=c --options=.astylerc --style=java"'
"    elseif filereadable(expand('~/.astylerc')) || exists('$ARTISTIC_STYLE_OPTIONS')
"        let g:formatdef_astyle_c = '"astyle --mode=c --style=java"'
"    else
"        let g:formatdef_astyle_c = '"astyle --mode=c --style=java -pcH".(&expandtab ? "s".shiftwidth() : "t")'
"    endif
"endif
"
"if !exists('g:formatters_c')
"    let g:formatters_c = ['astyle_c']
"endif


"if !exists('g:formatdef_clangformat')
"    let s:configfile_def = "'clang-format -lines='.a:firstline.':'.a:lastline.' --assume-filename=\"'.expand('%:p').'\" -style=Google'"
"    let s:noconfigfile_def = "'clang-format -lines='.a:firstline.':'.a:lastline.' --assume-filename=\"'.expand('%:p').'\" -style=\"{BasedOnStyle: Google, AlignTrailingComments: true, '.(&textwidth ? 'ColumnLimit: '.&textwidth.', ' : '').'IndentWidth: '.shiftwidth().', TabWidth: '.&tabstop.', '.(&expandtab ? 'UseTab: Never' : 'UseTab: Always').'}\"'"
"    let g:formatdef_clangformat = "g:ClangFormatConfigFileExists() ? (" . s:configfile_def . ") : (" . s:noconfigfile_def . ")"
"endif
"
"function! g:ClangFormatConfigFileExists()
"    return len(findfile(".clang-format", expand("%:p:h").";")) || len(findfile("_clang-format", expand("%:p:h").";")) || len(findfile("~/.clang-format", expand("%:p:h").";")) || len(findfile("~/_clang-format", expand("%:p:h").";"))
"endfunction
"
"
"if !exists('g:formatters_c')
"    let g:formatters_c = ['clangformat']
"endif



"python 路径
let g:python3_host_prog="/usr/bin/python"



"----------------------------------------------------------------------------------------------------------------------------------------------------------


"----------------------------------------------------------------------------------------------------------------------------------------------------------
"以下为coc设置
" TextEdit might fail if hidden is not set.
set hidden


" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
