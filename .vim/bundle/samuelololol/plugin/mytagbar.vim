"let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
let g:tagbar_type_html = {
    \ 'ctagstype' : 'html',
    \ 'kinds' : [
        \ 'f:JavaScript funtions',
        \ 'a:named anchors',
        \ 'r:html',
        \ 'b:body',
        \ 'o:object',
        \ 'c:class',
    \ ],
    \ 'ctagsargs' : '-f - --html-kinds=fabr'
    \ }
