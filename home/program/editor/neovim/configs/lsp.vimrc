nmap <leader>ld <Plug>(coc-definition)
nmap <leader>la <Plug>(coc-references)
nmap <leader>lr <Plug>(coc-rename)
noremap <leader>lh :call CocAction('doHover')<CR>
noremap <leader>lo :CocList outline<CR>
noremap <leader>lp :CocList diagnostics<CR>

autocmd CursorHold * silent call CocActionAsync('highlight')

