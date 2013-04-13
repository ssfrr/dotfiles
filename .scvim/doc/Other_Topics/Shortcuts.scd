Keyboard Shortcuts for SuperCollider




Functions


OSX


Win (PsyCollider)


sced


scvim


Emacs (scel)




Language-Specific Commands:




Interpret Selection


enter, ctl-c, ctl-return, shift-return


ctl-enter


ctl-e


F5


C-c C-d / C-c C-c




Interpret current line


enter, ctl-c, ctl-return, shift-return


ctl-enter


ctl-e


F6


C-c C-c




Interactively evaluate expression...














C-c C-e




Evaluate defun or code-block














C-M-x





Evaluate current document














C-c C-f





Stop


cmd-.


alt-.


escape


F12


C-c C-s




TempoClock.default.clear











F7







s.freeAll











F8







Run Main-run


cmd-r


alt-r








C-c C-r




Recompile library


cmd-k


alt-k





:SClangStart


C-c C-l




Stop interpreter











:SClangKill


M-x sclang-stop




Clear post window


cmd-sh-c


alt-p








C-c <




Open Help File


cmd-d


F1


ctl-u


K or :SChelp


C-c C-h




Open Class Definition (look up class file, either Class name or Class:method) e.g. Object, Object:dump


cmd-j


alt-j


ctl-y


^k or :SCdef


C-c :




Implementations of (which objects have code that defines methods, e.g. 'play')


cmd-y


alt-y








C-c :




References to (where in the source files is e.g. the method 'play' used?)


cmd-sh-Y


alt-sh-Y








C-c ;




Dump interface














C-c [




Dump full interface














C-c {




Show method arguments














C-c C-m / C-c RET




Autocomplete keyword














C-c C-n / M-TAB




Show server panels














C-c C-p p




Files:




Open text document


cmd-o


ctl-o


ctl-o


:e


C-x C-f




New text document


cmd-n


ctl-n


ctl-n


:enew


(open non-existent file w. new name)




Close text document


cmd-w


ctl-w


ctl-w


:close


C-x k




Save text document


cmd-s


ctl-s


ctl-s


:w


C-x C-s




Save text document as


cmd-sh-s


ctl-sh-s


ctl-sh-s


:sav


C-x C-w




HTML doc window => code win








ctl-t





E




Text Editing:




Undo


cmd-z


ctl-z


ctl-z


u


C-x u / C-_




Redo


cmd-sh-Z


ctl-y


ctl-sh-z


^R


C-x u / C-_




Copy


cmd-c


ctl-c


ctl-c


"+y


M-w




Paste


cmd-v


ctl-v


ctl-v


"+gP


C-y




Cut


cmd-x


ctl-x


ctl-x


"+x


C-w




Select all


cmd-a


ctl-a


ctl-a


ggVG


C-x a




Select block





ctl-b













Goto line ...


cmd-,





ctl-i


(linenumber)G


M-g g




Find ...


cmd-f





ctl-f


/ or *


C-s




Find next


cmd-g





ctl-g


*


C-s




Find previous


cmd-d





ctl-sh-g


#


C-r




Replace and find next


cmd-l











M-%




Replace


cmd-=





ctl-h





M-,




Copy text style only


cmd-alt-c
















Paste text style only


cmd-alt-v
















Formatting:




Syntax Colorise


cmd-'


auto


auto


auto


auto




Balance (find next matched parens/curly braces and select everything enclosed)


cmd-sh-B











C-<space>, C-M-f




Balance backwards (find previous matched parens/curly braces and select everything enclosed)














C-<space>, C-M-b




Paren match highlight











auto


auto with option Paren-Match-Highlighting




Comment (add // in front)


cmd-/


ctl-/








(select text and) M-;




Uncomment (remove //s)


cmd-sh-/


ctl-sh-/








(select text and) M-;




Indent / Shift left (move selected text by one tab)


cmd-[


ctl-t, tab








TAB (auto-aligns tabs according to code)




Unindent / Shift right (by one tab)


cmd-]


ctl-sh-t, shift-tab













Insert (): enclose selected text with (txt)


cmd-(
















Insert []: enclose selected text with [txt]


cmd-alt-[
















Insert {}: enclose selected text with {txt}


cmd-{
















Insert /* */: enclose selected text with /*txt*/


cmd-*

















