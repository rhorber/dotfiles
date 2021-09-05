" Silent version of the super user edit, sudo tee trick.
cnoremap W!! execute 'silent! write !sudo /usr/bin/tee "%" >/dev/null' <bar> edit!
" Talkative version of the super user edit, sudo tee trick.
cmap w!! w !sudo /usr/bin/tee >/dev/null "%"
