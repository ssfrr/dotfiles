The Emacs Editor

Here is a more extensive and elaborate overview of useful shortcuts in the Emacs Editor.
For a general reference to Emacs shortcut, check out this Emacs reference.



C-gAbort current action
C-hGeneral help on emacs
Interpreting code
C-c C-d(C-c C-c)Interpret Selection (only if transient-mark-mode is on)
C-c C-cInterpret current line
C-c C-eEvaluate expression (in minibuffer)
C-M-xInterpret defun
C-c C-fInterpret current document

Control the interpreter
C-c C-sStop (CmdPeriod) / Main.stop
C-c C-rMain.run
C-c C-lRecompile library
M-x sclang-stopStop interpreter
C-c C-p pShow server panels

Postbuffer and workspace
C-c C-wSwitch to workspace
C-c <Clear postbuffer
C-c >Show postbuffer

Help files
C-M-hShow help browser
C-c C-hOpen help file. You do not need to select a word before using the shortcut. It will suggest the word at the current cursor position, or lets you type a word in the minibuffer. There is autocompletion by typing <TAB>.
E(in the help browser) open the help file as plain text (in sclang-mode), so it can be edited.
C-c C-v(in the help browser) edit the help file as html code.

Finding things in class source files
C-c :Find definitions (method or class). Again, you can type the word you want to look for in the minibuffer and it suggests the word at the current cursor position.
C-c ;Find references to (method or class). (ditto)
C-c C-kOpen current file at the svn development path location. You need to have set the devpath variable in Platform for this to work properly, e.g.
thisProcess.platform.devpath = "~/svn/SuperCollider3".standardizePath;


Current code completion and interface
C-c [Dump interface
C-c {Dump full interface
C-c C-m / C-c RETShow method arguments (in minibuffer)
C-c C-n / M-TABAutocomplete keyword (either puts in the one possible completion, or pops up a buffer with possibilities from which you can choose one)


Files and buffers
C-x C-fOpen file or new file
C-x C-sSave file
C-x C-wSave file as
C-x C-vOpen another file in this buffer
C-x iInsert a file at cursor position
C-x bCreate/switch buffers
C-x C-bShow buffer list
C-x kKill buffer
C-zSuspend emacs
C-x C-cClose down emacs

Undo and recovery
C-x u / C-_Undo
C-x u / C-_Redo
M-x revert-buffer RETURNundo all changes since last save
M-x recover-file RETURNRecover text from an autosave-file
M-x recover-session RETURNRecover text from an autosave-files if you edited several files


Editing
M-wCopy
C-yPaste
C-wCut
C-x C-oDelete blank lines

Search and replace
C-sSearch / find. This allows you to set a string in the mini-buffer. The occurrences in the text will be highlighted and you can press C-s again and again to jump to next occurrences
C-rSearch / find backwards.
M-%Replace and find next
M-,Replace

Navigating and selecting
M-g gGoto line ...
C-x aSelect all

C-M-f
    zips you forward to matching parenthesis, so if you hover over the opening bracket, hit 
	 C-<space>, C-M-f, C-c C-c you can quickly execute a block.
   

C-M-b
    zips you backward to matching parenthesis. If you are just to the right of
closing brackets this is handier if you've just finished some code.
   


    C-f	Move forward a character


    C-bMove backward a character


    M-fMove forward a word


    M-bMove backward a word


    C-nMove to next line


    C-pMove to previous line


    C-aMove to beginning of line


    C-eMove to end of line


    M-aMove back to beginning of sentence


    M-eMove forward to end of sentence




Formatting
 M-x show-paren-modeParen match highlighting. Can also be set from the options menu.
M-;Add comment. If you have a text selected, then that text will become a comment. It will remove the commenting // when you have selected a commented text.
C-M-jContinue the comment on the next line.
C-u M-;Remove comment. This removes the whole comment, so also the text!
M-x comment-regionComments the selected region
M-x uncomment-regionUncomments the selected region
TABAuto-aligns tabs according to code.



Marks
(info from EmacsWiki)

set-mark-command (`C-SPC')

A nice feature that not all know about is what happens if you feed it with a universal argument: ‘C-u C-SPC’. It’s an easy way to navigate back to your previous editing spots by jumping to the positions stored in the buffer’s local mark ring. Repeated calls will cycle through the ring of marks.

If you use TransientMarkMode and you want to set the mark but don’t want to subsequently see the region highlighting, you can use ‘C-SPC C-g’ to set the mark and then deactivate it.

pop-global-mark (`C-x C-SPC')

In addition to the ordinary mark ring that belongs to each buffer, Emacs has a single global mark ring. It records a sequence of buffers in which you have recently set the mark, so you can go back to those buffers.

Setting the mark always makes an entry on the current buffer’s mark ring. If you have switched buffers since the previous mark setting, the new mark position makes an entry on the global mark ring also. The result is that the global mark ring records a sequence of buffers that you have been in, and, for each buffer, a place where you set the mark.

‘C-x C-SPC’ (‘pop-global-mark’) jumps to the buffer and position of the latest entry in the global mark ring. It also rotates the ring, so that successive uses of ‘C-x C-SPC’ take you to earlier and earlier buffers.

Customsing Emacs' behaviour

You can customize the behaviour of Emacs, by putting things in the startup file of emacs. This file is ~/.emacs.

You can define options there, for example:


(custom-set-variables
 '(case-fold-search t)
 '(global-font-lock-mode t nil (font-lock))
 '(sclang-runtime-directory "~/SuperCollider/")
 '(show-paren-mode t nil (paren))
 '(transient-mark-mode t)
)


nil means that an option is turned off, t or 1 means that it is turned on.


'(sclang-eval-line-forward nil)Configure the text cursor NOT to move after hitting C-c C-c


Customize w3m

Normally w3m uses the arrow keys to jump between hyperlinks. For browsing SC help files this is not very useful.


(eval-after-load "w3m"
 '(progn
 (define-key w3m-mode-map [left] 'backward-char)
 (define-key w3m-mode-map [right] 'forward-char)
 (define-key w3m-mode-map [up] 'previous-line)
 (define-key w3m-mode-map [down] 'next-line)
 (setq w3m-auto-show 1)
 ))


Automatically complete brackets and parentheses

      (setq skeleton-pair t)
      (global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
      (global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
      (global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
      (global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
      (global-set-key (kbd "'") 'skeleton-pair-insert-maybe)


Scrollwheel support

;;; scrollwheel support
(defun scroll-up-half ()
  "Scroll up half a page."
  (interactive)
  (scroll-up (/ (window-height) 2))
  )

(defun scroll-down-half ()
  "Scroll down half a page."
  (interactive)
  (scroll-down (/ (window-height) 2))
  )
(global-set-key [(mouse-5)] 'scroll-up-half)
(global-set-key [(mouse-4)] 'scroll-down-half)



Recent files menu

Recentf is a minor mode that builds a list of recently opened files. This list is is automatically saved across Emacs sessions. You can then access this list through a menu.
Put this in your `~/.emacs’:

    (require 'recentf)
    (recentf-mode 1)




For adding a shortcut (C-x C-r) to open a recent file add this code as well:


    (defun recentf-open-files-compl ()
      (interactive)
      (let* ((all-files recentf-list)
        (tocpl (mapcar (function
           (lambda (x) (cons (file-name-nondirectory x) x))) all-files))
        (prompt (append '("File name: ") tocpl))
        (fname (completing-read (car prompt) (cdr prompt) nil nil)))
        (find-file (cdr (assoc-ignore-representation fname tocpl)))))

    (global-set-key "\C-x\C-r" 'recentf-open-files-compl)



More info on Emacs
Emacs Wiki


