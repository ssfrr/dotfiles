let g:template['c']['for'] = "for(".g:rs."...".g:re."; ".g:rs."...".g:re."; ".g:rs."...".g:re.")\<cr>{\<cr>".
            \g:rs."...".g:re."\<cr>}\<cr>".g:rs."...".g:re
let g:template['c']['switch'] = "switch (".g:rs."...".g:re.")\<cr>{\<cr>case ".g:rs."...".g:re.":\<cr>break;\<cr>case ".
            \g:rs."...".g:re.":\<cr>break;\<cr>default:\<cr>break;\<cr>}".g:rs."...".g:re
let g:template['c']['if'] = "if(".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>}".g:rs."...".g:re
let g:template['c']['while'] = "while( ".g:rs."...".g:re." )\<cr>{\<cr>".g:rs."...".g:re."\<cr>}".g:rs."...".g:re
let g:template['c']['ife'] = "if( ".g:rs."...".g:re." )\<cr>{\<cr>".g:rs."...".g:re."\<cr>} else\<cr>{\<cr>".g:rs."...".
            \g:re."\<cr>}".g:rs."...".g:re
let g:template['c']['else'] = "else\<cr>{\<cr>".g:rs."...".g:re."\<cr>}".g:rs."...".g:re
