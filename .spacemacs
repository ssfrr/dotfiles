;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     helm
     ;; auto-completion
     ;; better-defaults
     emacs-lisp
     ;; git
     ;; markdown
     org
     ;; (shell :variables
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     ;; spell-checking
     ;; syntax-checking
     ;; version-control
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages
   '(
     helm-bibtex
     org-ref
     org-drill-table
     visual-fill-column
     )
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages
   '(
     org-projectile ;; incompatible with spacemacs v0.200.10
     adaptive-wrap ;; messes up wrapping with org-indent-mode
     )
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 15
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'original
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  )

(defun insert-url-as-org-link ()
  "If there's a URL on the clipboard, insert it as an org-mode
link in the form of [[url][*]], and leave point at *."
  (interactive)
  (let* ((clipdata (or (x-get-selection 'CLIPBOARD) "")) ; selection is nil for empty
         (link (substring-no-properties clipdata))
         (url  "\\(http[s]?://\\|www\\.\\)"))
    (save-match-data
      (if (string-match url link)
          (progn
            (insert (concat "[[" link "][]]"))
            (backward-char 2))
        (error "No URL on the clipboard")))))

;; modified from example at http://ergoemacs.org/emacs/emacs_dired_open_file_in_ext_apps.html
(defun open-in-external-app (fpath)
  "Open the given file. The app is chosen from your OS's preference."
  (cond
   ((string-equal system-type "windows-nt")
    (w32-shell-execute "open" (replace-regexp-in-string "/" "\\" fpath t t)))
   ((string-equal system-type "darwin")
    (shell-command
     (concat "open " (shell-quote-argument fpath))))
   ((string-equal system-type "gnu/linux")
    (let ((process-connection-type nil))
      (start-process "" nil "xdg-open" fpath)))))

;; Improved RET behavior in org-mode, stolen whole-cloth from
;; https://github.com/jkitchin/scimax/blob/9f71d3cd4a766c168772f293d9d6890266e210d1/scimax-org.el#L1258
(defun better-org-return (&optional ignore)
  "Add new list item, heading or table row with RET. A double return on an empty
   element deletes it. Use a prefix arg to get regular RET. "
  (interactive "P")
  (if ignore
      (org-return)
    (cond

     ((eq 'line-break (car (org-element-context)))
      (org-return-indent))

     ;; Open links like usual, unless point is at the end of a line.
     ;; and if at beginning of line, just press enter.
     ((or (and (eq 'link (car (org-element-context))) (not (eolp)))
          (bolp))
      (org-return))

     ;; It doesn't make sense to add headings in inline tasks. Thanks Anders
     ;; Johansson!
     ((org-inlinetask-in-task-p)
      (org-return))

     ;; checkboxes too
     ((org-at-item-checkbox-p)
      (if (org-element-property :contents-begin
                                (org-element-context))
          ;; we have content so add a new checkbox
          (org-insert-todo-heading nil)
        ;; no content so delete it
        (setf (buffer-substring (line-beginning-position) (point)) "")
        (org-return)))

     ;; lists end with two blank lines, so we need to make sure we are also not
     ;; at the beginning of a line to avoid a loop where a new entry gets
     ;; created with only one blank line.
     ((org-in-item-p)
      (if (save-excursion
            (beginning-of-line) (org-element-property :contents-begin (org-element-context)))
          (org-insert-item)
        (beginning-of-line)
        (delete-region (line-beginning-position) (line-end-position))
        (org-return)))

     ;; org-heading
     ((org-at-heading-p)
      (if (not (string= "" (org-element-property :title (org-element-context))))
          (progn
            ;; Go to end of subtree suggested by Pablo GG on Disqus post.
            (org-end-of-subtree)
            (org-insert-heading-respect-content)
            (outline-show-entry))
        ;; The heading was empty, so we delete it
        (beginning-of-line)
        (setf (buffer-substring
               (line-beginning-position) (line-end-position)) "")))

     ;; tables
     ((org-at-table-p)
      (if (-any?
           (lambda (x) (not (string= "" x)))
           (nth
            (- (org-table-current-dline) 1)
            (remove 'hline (org-table-to-lisp))))
          (org-return)
        ;; empty row
        (beginning-of-line)
        (setf (buffer-substring
               (line-beginning-position) (line-end-position)) "")
        (org-return)))

     ;; fall-through case
     (t
      (org-return)))))

(defun org-pom-notify (msg)
  "Send an org-pomodoro desktop notification"
  ;; note that they're required to be closed before another can be displayed, but there's no
  ;; problem with double-closing and the ID seems to always be 42, so we just proactively close
  ;; any open notifications before trying to display another.
    (w32-notification-close 42)
    (w32-notification-notify :title "org-pomodoro" :body msg))

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."
  ;; move through softwrapped lines naturally
  ;; from https://stackoverflow.com/a/20899418/269247
  (define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
  (define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
  (define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
  ;; make horizontal movement cross lines
  (setq-default evil-cross-lines t)

  ;; enable <C-RET> for code eval
  (global-set-key (kbd "C-<return>") 'eval-defun)
  (global-set-key (kbd "C-S-<return>") 'eval-buffer)
  (spacemacs/set-leader-keys "b z" `visual-fill-column-mode) ; toggle wrapping

  ;; Some generic file-handling config
  (setq vc-follow-symlinks t) ; act as if we'd opened the real file, makes VC integration work better
  (with-eval-after-load "org"
    (require 'ox-md nil t) ; enable markdown export for org mode
    (setq org-startup-indented t) ; Enable `org-indent-mode' by default
    ;; (require 'org-inlinetask) ; needed for better-org-return
    ;; (evil-define-key 'insert org-mode-map (kbd "RET") 'better-org-return)
    (evil-define-key 'normal org-mode-map (kbd "X") 'org-toggle-latex-fragment)
    (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.25)) ; bigger latex previews
    )
  ;;(setq auto-save-visited-file-name t) ; save directly to the file
  (setq auto-save-timeout 300) ; number of idle seconds before saving

  ;; Bibliography config
  (require 'org-ref)
  (define-key evil-normal-state-map "\"" 'org-ref-insert-link)
  (setq bibtex-completion-bibliography '("~/bibliography.bib"))
  (setq org-ref-default-bibliography bibtex-completion-bibliography)
  (setq bibtex-completion-pdf-field "file")
  (setq bibtex-completion-notes-path "~/Dropbox/org/bibliography.org")
  (setq org-ref-bibliography-notes bibtex-completion-notes-path)
  (setq bibtex-completion-notes-template-one-file
"
* ${author} (${year}): ${title}
:PROPERTIES:
:Custom_ID: ${=key=}
:END:
cite:${=key=}
")
  (define-key evil-normal-state-map (kbd "C-' C-'") 'helm-bibtex)
  (define-key evil-insert-state-map (kbd "C-' C-'") 'helm-bibtex)
  (setq bibtex-completion-pdf-open-function 'open-in-external-app)
  (with-eval-after-load "org-ref"
    ;; adapted from @shu-cheng at https://github.com/jkitchin/org-ref/issues/485
    (setq org-ref-open-pdf-function
          (lambda ()
            (let* ((results (org-ref-get-bibtex-key-and-file))
                   (key (car results)))
              (bibtex-completion-open-pdf (list key)))))
    ;; use helm-bibtex's note creation function. As of 2017-12-13 it's better at
    ;; handling BibLaTeX-formatted files, which use =date= rather than =year= in
    ;; interactive use the given key is (often?) =nil= so the function should
    ;; use whatever is under the point
    (setq org-ref-notes-function
          (lambda (maybekey)
            (let*
                ((key (car (org-ref-get-bibtex-key-and-file maybekey))))
              (bibtex-completion-edit-notes (list key))))))

  ;; Org Agenda Config
  (setq org-agenda-skip-scheduled-if-done t)
  (setq org-agenda-skip-deadline-if-done t)
  (setq org-todo-keywords
        '((sequence "TODO(t)" "DOING(g)" "BLOCKED(b)" "|" "DONE(d)" "CANCELED(c)")))
  (setq org-blank-before-new-entry '((heading . nil)
                                     (plain-list-item . nil)))
  (setq org-agenda-files '("~/Dropbox/org"))
  (add-hook 'text-mode-hook #'turn-on-visual-line-mode)
  (setq undo-tree-visualizer-diff nil) ; disable the diff in the undo tree
  ;; force undo-tree enabled in org mode
  (add-hook 'org-mode-hook (lambda ()
                             (undo-tree-mode 1)))

  (define-key evil-normal-state-map (kbd "C-l") 'insert-url-as-org-link)
  (define-key evil-insert-state-map (kbd "C-l") 'insert-url-as-org-link)
  ;; (setq org-refile-targets '((("~/Dropbox/org/todo.org") :maxlevel . 2)))
  (setq org-refile-use-outline-path 'file)
  (setq org-refile-targets '((org-agenda-files :maxlevel . 2)))
  (setq org-refile-allow-creating-parent-nodes 'confirm)
  (setq org-outline-path-complete-in-steps nil) ; show children all at once to helm
  (setq org-agenda-sorting-strategy
        '((agenda todo-state-up habit-down time-up priority-down category-keep)
          (todo priority-down category-keep)
          (tags priority-down category-keep)
          (search category-keep)))
  (setq org-agenda-span 'day)
  ;; this view is in-progress - can't figure out how to show DONE items in log mode
  ;; but not in the item list
  (setq org-agenda-custom-commands
        '(("d" "Day View"
           ((agenda ""
                    ((org-agenda-span 'day)
                     (org-agenda-skip-function
                      '(org-agenda-skip-entry-if 'todo 'done)))
                    (alltodo ""))))))
  (setq org-default-notes-file "~/Dropbox/org/capture.org")
  (setq org-capture-templates
        '(("t" "Todo")
          ("tt" "Todo" entry (file "")
"* TODO %?
%i")
          ("tl" "Todo (Linked)" entry (file "")
"* TODO %?
%i
[[%l][link]]")
          ("d" "Drill Card")
          ("dn" "Drill Card (single-sided)" entry (file "")
"* %?     :drill:
** Term
** Definition
")
          ("dt" "Drill Card (two-sided)" entry (file "")
"* %?     :drill:
:PROPERTIES:
:DRILL_CARD_TYPE: twosided
:END:
** Term
** Definition
")
          ("dm" "Drill Card (multi-sided)" entry (file "")
"* %?     :drill:
:PROPERTIES:
:DRILL_CARD_TYPE: multisided
:END:
** Term
** Definition
")
          ("j" "Journal" entry (file+olp+datetree "~/Dropbox/org/journal.org")
"* %?
Entered on %U
%i")))
  ;; workaround for hl-todo-mode messing up highlighting in org TODO lists
  (add-hook 'org-mode-hook (lambda () (hl-todo-mode -1) nil))
  ;; make it so expanding/collapsing org-mode headings doesn't jump the window
  (remove-hook 'org-cycle-hook
               'org-optimize-window-after-visibility-change)
  (setq org-log-into-drawer t)
  ;; org-pomodoro mode hooks
  (with-eval-after-load "org-pomodoro"
    (add-hook 'org-pomodoro-started-hook
              (lambda ()
                (org-pom-notify "Pomodoro Started. You can do it!")))
    (add-hook 'org-pomodoro-finished-hook
              (lambda ()
                (org-pom-notify "Pomodoro Finished, time for a break")))
    (add-hook 'org-pomodoro-break-finished-hook
              (lambda ()
                (org-pom-notify "Break Finished, try one more!")))
    (add-hook 'org-pomodoro-long-break-finished-hook
              (lambda ()
                (org-pom-notify "Long Break Finished, try one more!")))
    (add-hook 'org-pomodoro-killed-hook
              (lambda ()
                (org-pom-notify "Pomodoro Cancelled"))))
)

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-modules (quote (org-bibtex org-drill org-learn)))
 '(org-export-backends (quote (ascii html icalendar latex md odt)))
 '(org-export-initial-scope (quote subtree))
 '(package-selected-packages
   (quote
    (visual-fill-column org-drill-table org-mime org-ref pdf-tools key-chord ivy tablist helm-bibtex biblio parsebib biblio-core zotxt request-deferred deferred org-projectile org-category-capture org-present org-pomodoro alert log4e gntp org-download htmlize gnuplot ws-butler winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline powerline restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox spinner org-plus-contrib org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint info+ indent-guide hydra hungry-delete hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-projectile helm-mode-manager helm-make projectile pkg-info epl helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido flx fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg undo-tree eval-sexp-fu highlight elisp-slime-nav dumb-jump f dash s diminish define-word column-enforce-mode clean-aindent-mode bind-map bind-key auto-highlight-symbol auto-compile packed aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line helm avy helm-core popup async))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
