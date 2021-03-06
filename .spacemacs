;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

;; set defaults that can be overridden by a .spacemacs_local config
(setq sfr-fontsize 12)
(setq sfr-latexscale 1.5)
;; workaround for emacs bug that should be fixed in emacs 26.3+
;; discovered here: https://www.reddit.com/r/emacs/comments/cdei4p/failed_to_download_gnu_archive_bad_request/
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(if (file-exists-p "~/.spacemacs_local")
    (load-file "~/.spacemacs_local")
    (message "~/.spacemacs_local doesn't exist, no local configuration applied"))

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
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
   '(csv
     markdown
     html
     ;; csv
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     helm
     auto-completion
     ;; better-defaults
     emacs-lisp
     ;; git
     ;; markdown
     org
     (org :variables
          org-enable-reveal-js-support t)
     ;; (shell :variables
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     spell-checking
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
     ;; ob-ipython
     jupyter
     julia-mode
     evil-commentary
     company-math
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
   ;; If non-nil then enable support for the portable dumper. You'll need
   ;; to compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; File path pointing to emacs 27.1 executable compiled with support
   ;; for the portable dumper (this is currently the branch pdumper).
   ;; (default "emacs-27.0.50")
   dotspacemacs-emacs-pdumper-executable-file "emacs-27.0.50"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=~/.emacs.d/.cache/dumps/spacemacs.pdmp
   ;; (default spacemacs.pdmp)
   dotspacemacs-emacs-dumper-dump-file "spacemacs.pdmp"

   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default nil)
   dotspacemacs-verify-spacelpa-archives nil

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim

   ;; If non-nil output loading progress in `*Messages*' buffer. (default nil)
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

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light)

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `doom', `vim-powerline' and `vanilla'. The
   ;; first three are spaceline themes. `doom' is the doom-emacs mode-line.
   ;; `vanilla' is default Emacs mode-line. `custom' is a user defined themes,
   ;; refer to the DOCUMENTATION.org for more info on how to create your own
   ;; spaceline theme. Value can be a symbol or list with additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(spacemacs :separator wave :separator-scale 1.5)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font `("Source Code Pro"
                               :size ,sfr-fontsize
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
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
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
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

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
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
   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
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

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
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

   ;; If non-nil `smartparens-strict-mode' will be enabled in programming modes.
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

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server nil

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I@%S"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil))

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env))

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  )

(defun insert-clipboard-as-org-link ()
  "If there's a URL on the clipboard, insert it as an org-mode
link in the form of [[url][*]], and leave point at *."
  (interactive)
  (let* ((clipdata (or (x-get-selection 'CLIPBOARD) "")) ; selection is nil for empty
         (raw (substring-no-properties clipdata))
         (url-regex  "^http[s]?://\\|www\\.")
         (file-regex "^/.*"))
    (save-match-data
      (cond ((string-match url-regex raw)
             (progn
               (insert (concat "[[" raw "][]]"))
               (backward-char 2)))
            ((string-match file-regex raw)
             (progn
               (insert (concat "[[file:" raw "][]]"))
               (backward-char 2)))
            (t (error "No recognized link target on the clipboard"))))))

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
  (cond
   ((string-equal system-type "windows-nt")
    ;; note that they're required to be closed before another can be displayed, but there's no
    ;; problem with double-closing and the ID seems to always be 42, so we just proactively close
    ;; any open notifications before trying to display another.
    (w32-notification-close 42)
    (w32-notification-notify :title "org-pomodoro" :body msg))
   ((string-equal system-type "darwin")
    (message "Pomodoro notifications not yet supported on OSX"))
   ((string-equal system-type "gnu/linux")
    (notifications-notify :title "org-pomodoro" :body msg))))

(defun sfr-save-org-buffers ()
  "Save all org buffers that are visiting a file"
  (mapc (lambda (buf)
          (if (buffer-file-name buf)
              (with-current-buffer buf (save-buffer))))
        (org-buffer-list 'files)))

(defun sfr-comment-line ()
    (interactive)
  (comment-line 1))

(defun dotspacemacs/user-load ()
  "Library to load while dumping.
This function is called only while dumping Spacemacs configuration. You can
`require' or `load' the libraries of your choice that will be included in the
dump."
  )

(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration.
Put your configuration code here, except for variables that should be set
before packages are loaded."
  ;; open .jmd files with markdown mode
  (add-to-list 'auto-mode-alist '("\\.jmd$" . markdown-mode))
  ;; apparently faster than the default scp
  (setq tramp-default-method "ssh")
  ;; move through softwrapped lines naturally
  ;; from https://stackoverflow.com/a/20899418/269247
  (define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
  (define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
  (define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
  ;; enable auto-indent on RET
  ;; (evil-define-key 'insert org-mode-map (kbd "RET") 'newline-and-indent)
  ;; make horizontal movement cross lines
  (setq-default evil-cross-lines t)

  ;; enable <C-RET> for code eval
  (global-set-key (kbd "C-<return>") 'eval-defun)
  (global-set-key (kbd "C-S-<return>") 'eval-buffer)
  (spacemacs/set-leader-keys "b z" `visual-fill-column-mode) ; toggle wrapping

  ;; Some generic file-handling config
  (setq vc-follow-symlinks t) ; act as if we'd opened the real file, makes VC integration work better
  (setq exec-path-from-shell-check-startup-files t) ; don't complain about setting PATH from .zshrc
  (with-eval-after-load "org"
    (require 'ox-md) ; enable markdown export for org mode
    (require 'ox-reveal) ; enable reveal.js export
    ;; set clock report time format (default shows 24hrs as "days")
    (setq org-duration-format (quote h:mm))
    (setq org-export-initial-scope 'subtree)
    (setq org-startup-indented t) ; Enable `org-indent-mode' by default
    (setq org-src-tab-acts-natively t)
    (setq org-src-preserve-indentation t)
    (setq org-clock-mode-line-total 'today)
    ;; show the currently clocked task in the modeline
    (spaceline-toggle-org-clock-on)
    ;; currently ob-ipython seems to be throwing an error, so disable it
    ;; (require 'ob-ipython)
    ;; (org-babel-do-load-languages
    ;;   'org-babel-load-languages
    ;;   '((ipython . t)
    ;;     ;; other languages..
    ;;     ))
    ;; ;; use the julia-installed python stuff to run jupyter
    ;; (setq ob-ipython-resources-dir "C:\\Users\\sfr\\Dropbox\\org\\obipy-resources\\")
    ;; (setq ob-ipython-command "~/Miniconda3/Scripts/jupyter")
    (org-babel-do-load-languages
     'org-babel-load-languages
     '(;;(emacs-lisp . t)
       ;;(julia . t)
       ;;(python . t)
       (jupyter . t)))
    (spacemacs/set-leader-keys "j h" 'helm-org-agenda-files-headings)
    (define-key evil-normal-state-map (kbd "M-<return>") 'org-babel-execute-src-block)
    (define-key evil-insert-state-map (kbd "M-<return>") 'org-babel-execute-src-block)
    ;; don't prompt me to confirm everytime I want to evaluate a block
    (setq org-confirm-babel-evaluate nil)
    ;; (setq python-shell-interpreter "~/Miniconda3/python")
    (add-to-list 'org-structure-template-alist
                 '("j"
"
#+BEGIN_SRC ipython :session :results raw drawer :kernel julia-0.6
?
#+END_SRC
"))
    ;; (require 'org-inlinetask) ; needed for better-org-return
    ;; (evil-define-key 'insert org-mode-map (kbd "RET") 'better-org-return)
    (evil-define-key 'normal org-mode-map (kbd "C-k") 'org-toggle-latex-fragment)
    (evil-define-key 'insert org-mode-map (kbd "C-k") 'org-toggle-latex-fragment)
    (evil-define-key 'normal 'global (kbd "C-/") 'comment-line)
    (evil-define-key 'visual 'global (kbd "C-/") 'comment-line)
    ;; set some keys that were changed in recent versions of spacemacs
    (spacemacs/set-leader-keys-for-major-mode 'org-mode "I" 'org-clock-in)
    (spacemacs/set-leader-keys-for-major-mode 'org-mode "O" 'org-clock-out)
    (spacemacs/set-leader-keys-for-major-mode 'org-agenda-mode "I" 'org-agenda-clock-in)
    (spacemacs/set-leader-keys-for-major-mode 'org-agenda-mode "O" 'org-agenda-clock-out)
    (spacemacs/set-leader-keys-for-major-mode 'org-mode "R" 'org-refile)
    ;; bigger latex previews
    (setq org-format-latex-options (plist-put org-format-latex-options :scale sfr-latexscale)))
  ;;(setq auto-save-visited-file-name t) ; save directly to the file
  (setq auto-save-timeout 300) ; number of idle seconds before saving
  ;; custom auto-save for org files, so they stay synced even if I forget to save.
  ;; for some reason the default auto-save doesn't clear the lockfiles, so we roll
  ;; our own
  (run-with-idle-timer auto-save-timeout t 'sfr-save-org-buffers)
  ;; set html export to use HTML checkboxes
  (setq org-html-checkbox-type 'html)
  ;; Bibliography config
  (require 'org-ref)
  ;; override the built-in bibtex reference formatting to strip braces {{}}
  (defun org-ref-format-entry (key)
    "Returns a formatted bibtex entry for KEY."
    (let* ((bibtex-completion-bibliography (org-ref-find-bibliography))
	         (s (org-ref-format-bibtex-entry (ignore-errors (bibtex-completion-get-entry key)))))
      (replace-regexp-in-string "{\\|}" "" s)))
  ;; use fancier formatted citations with org-mode formatting
  (setq org-ref-formatted-citation-backend "org")
  ;; override org-ref's default citation formats when copying into org and text files. My
  ;; bibliography database tends to be not so clean, so we only want minimal fields
  (setq org-ref-formatted-citation-formats
        '(("text"
           ("article" . "${author}, ${title}, ${journal}, ${volume}(${number}), ${pages} (${year}). ${doi}")
           ("inproceedings" . "${author}, ${title}, In ${editor}, ${booktitle} (pp. ${pages}) (${year}). ${address}: ${publisher}.")
           ("book" . "${author}, ${title} (${year}), ${address}: ${publisher}.")
           ("phdthesis" . "${author}, ${title} (Doctoral dissertation) (${year}). ${school}, ${address}.")
           ("inbook" . "${author}, ${title}, In ${editor} (Eds.), ${booktitle} (pp. ${pages}) (${year}). ${address}: ${publisher}.")
           ("incollection" . "${author}, ${title}, In ${editor} (Eds.), ${booktitle} (pp. ${pages}) (${year}). ${address}: ${publisher}.")
           ("proceedings" . "${editor} (Eds.), ${booktitle} (${year}). ${address}: ${publisher}.")
           ("unpublished" . "${author}, ${title} (${year}). Unpublished manuscript.")
           (nil . "${author}, ${title} (${year})."))
          ("org"
           ("article" . "${author}, /${title}/, ${journal}, *${volume}(${number})*, ${pages} (${year}). ${doi}")
           ("inproceedings" . "${author}, /${title}/, In ${booktitle} (pp. ${pages}) (${year}). ${address}")
           ("book" . "${author}, /${title}/ (${year}), ${address}: ${publisher}.")
           ("phdthesis" . "${author}, /${title}/ (Doctoral dissertation) (${year}). ${school}, ${address}.")
           ("inbook" . "${author}, /${title}/, In ${editor} (Eds.), ${booktitle} (pp. ${pages}) (${year}). ${address}: ${publisher}.")
           ("incollection" . "${author}, /${title}/, In ${editor} (Eds.), ${booktitle} (pp. ${pages}) (${year}). ${address}: ${publisher}.")
           ("proceedings" . "${editor} (Eds.), _${booktitle}_ (${year}). ${address}: ${publisher}.")
           ("unpublished" . "${author}, /${title}/ (${year}). Unpublished manuscript.")
           (nil . "${author}, /${title}/ (${year})."))))
  (define-key evil-normal-state-map "\"" 'org-ref-insert-link)
  ;; make it so that when leaving insert mode the cursor doesn't get moved back 1. This way we can insert
  ;; things where we want them.
  (setq evil-move-cursor-back nil)
  (setq bibtex-completion-bibliography '("~/bibliography.bib"))
  (setq org-ref-default-bibliography bibtex-completion-bibliography)
  (setq bibtex-completion-pdf-field "file")
  (setq bibtex-completion-notes-path "~/Dropbox/org/bibliography.org")
  (setq org-ref-bibliography-notes bibtex-completion-notes-path)
  ;; set up latex export to run bibtex
  (setq org-latex-pdf-process (list "latexmk -shell-escape -bibtex -f -pdf %f"))
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
  ; prevent headlines from being bigger than normal text
  (add-hook 'org-mode-hook
            (lambda ()
              (dolist (face '(org-level-1
                              org-level-2
                              org-level-3
                              org-level-4
                              org-level-5))
                (set-face-attribute face nil :weight 'semi-bold :height 1.0))))

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
  (setq org-clock-report-include-clocking-task t)
  (setq org-agenda-log-mode-items '(clock state))
  (setq org-todo-keywords
        '((sequence "TODO(t)" "BLOCKED(b@/!)" "|" "CANCELED(c@/!)" "DONE(d!/!)")))
  (setq org-log-reschedule 'time)
  (setq org-log-redeadline 'time)
  (setq org-log-into-drawer t)
  (setq org-log-done nil) ; don't add CLOSED line because we're logging in the logbook
  ;; refile into top rather than bottom of headings
  ;; NOTE: I don't know why I wanted this at some point.
  ;; (setq org-reverse-note-order t)
  (setq org-blank-before-new-entry '((heading . nil)
                                     (plain-list-item . nil)))
  ;; note that this will update the agenda files list whenver this config is evaluated,
  ;; not every time the agenda is opened
  (setq org-agenda-files (append `("~/Dropbox/org/todo.org"
                                   "~/Dropbox/org/habits.org"
                                   "~/Dropbox/org/capture.org")
                                 (f-glob "~/Dropbox/org/p_*.org")))
  ;; use global tags list from agenda files when offering tag completion
  ;; (setq org-complete-tags-always-offer-all-agenda-tags t)
  (add-hook 'text-mode-hook #'turn-on-visual-line-mode)
  (setq undo-tree-visualizer-diff nil) ; disable the diff in the undo tree
  ;; force undo-tree enabled in org mode
  (add-hook 'org-mode-hook (lambda ()
                             (undo-tree-mode 1)))

  (define-key evil-normal-state-map (kbd "C-l") 'insert-clipboard-as-org-link)
  (define-key evil-insert-state-map (kbd "C-l") 'insert-clipboard-as-org-link)
  (setq org-id-link-to-org-use-id t) ;; store org-mode links using IDs
  (setq org-refile-use-outline-path 'file)
  ;; note this will get the list of refile targets when this config is evaluated
  ;; not every time the agenda is opened
  (setq org-refile-targets `((,(cons "~/Dropbox/org/notes.org" org-agenda-files) . (:maxlevel . 2))))
  (setq org-refile-allow-creating-parent-nodes 'confirm)
  ;; short list of common tags to be set with ,,
  (setq org-tag-alist '(("PROJECT" . ?p) ("FOCUSED" . ?f) ("HABIT" . ?h)))
  ;; tasks without an explicit priority are treated as lowest priority
  (setq org-default-priority org-lowest-priority)
  (setq org-outline-path-complete-in-steps nil) ; show children all at once to helm
  ;; (setq org-agenda-sorting-strategy
  ;;       '((agenda ts-up priority-down)
  ;;         (todo ts-up priority-down)
  ;;         (tags priority-down category-keep)
  ;;         (search category-keep)))
  (setq org-agenda-span 'day)
  ;; don't use different font heights for emphasis in the agenda
  ;; (setq spacemacs-theme-org-agenda-height nil)
  (custom-set-faces
   '(org-agenda-done ((t (:foreground "#86dc2f" :height 1.0)))))

  (custom-set-faces
   '(org-scheduled-today ((t (:foreground "#bc6ec5" :height 1.0)))))
  (setq org-agenda-prefix-format '((agenda . " %-12:c%?-12t% s")
                                   (todo . " %-12:c%l")
                                   (tags . " %-12:c%l")
                                   (search . " %-12:c%l")))
  ;; don't display items and files with 0 times in the clockreport
  (setq org-agenda-clockreport-parameter-plist
        '(:link t :maxlevel 2 :stepskip0 t :fileskip0 t))
  (setq org-agenda-custom-commands
        '(;; scheduled TODOs for today, and my focused project for the week
          ("d" "Daily Agenda"
           ((agenda "" ((org-agenda-sorting-strategy
                         '(time-up deadline-up scheduled-up))))
            (tags "PROJECT+FOCUSED/TODO|BLOCKED"
                  ((org-agenda-skip-function '(org-agenda-skip-entry-if 'scheduled)))))
           ((org-agenda-start-with-log-mode '(clock state))))
          ;; all top-level headings with the PROJECT tag
          ("p" "Projects" tags "PROJECT"
           ((org-use-tag-inheritance nil)))
          ;; tasks completed within the past week or scheduled in the next week,
          ;; and a time report
          ("r" "Weekly Review"
           ((agenda "" ((org-agenda-span 7)
                        (org-agenda-start-day "-7d")
                        (org-agenda-overriding-header "Last Week")
                        (org-agenda-clockreport-mode t)))
            (agenda "" ((org-agenda-span 7)
                        (org-agenda-overriding-header "This Week"))))
           ((org-agenda-start-with-log-mode '(state))
            (org-agenda-use-tag-inheritance nil)
            (org-agenda-show-all-dates t)
            (org-agenda-time-grid nil)
            (org-agenda-start-on-weekday nil)))
          ;; TODOs that are not part of a project and are not currently scheduled
          ("m" "Misc. Dangling ToDos" tags "-PROJECT-HABIT/TODO|BLOCKED"
           ((org-agenda-skip-function '(org-agenda-skip-entry-if 'scheduled 'deadline))))
          ;; done TODOs that are not part of a project (need to be archived)
          ("a" "ToDos to Archive" tags "-PROJECT-HABIT/DONE|CANCELED")))
  ;; added with-eval-after-load so the spacemacs layer wouldn't clobber this config
  (with-eval-after-load 'org
    (setq org-default-notes-file "~/Dropbox/org/capture.org"))
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
          ("j" "Journal")
          ("jr" "Journal (Research)" entry (file+olp+datetree "~/Dropbox/org/j_research.org")
"* %?
Entered on %U
%i")
          ("jp" "Journal (Personal)" entry (file+olp+datetree "~/Dropbox/org/j_personal.org")
"* %?
Entered on %U
%i")))
  ;; workaround for hl-todo-mode messing up highlighting in org TODO lists
  (add-hook 'org-mode-hook (lambda () (hl-todo-mode -1) nil))
  ;; make it so expanding/collapsing org-mode headings doesn't jump the window
  (remove-hook 'org-cycle-hook
               'org-optimize-window-after-visibility-change)
  (setq yas-snippet-dirs (cons "/home/sfr/.yasnippets" yas-snippet-dirs))
  ;; org-pomodoro mode hooks
  (with-eval-after-load "org-pomodoro"
    (setq org-pomodoro-play-sounds nil)
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
  ;; enable unicode math symbol completion
  (with-eval-after-load 'company
    (setq company-global-modes '(not org-mode))
    (add-to-list 'company-backends 'company-math-symbols-unicode))
)

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-modules (quote (org-bibtex org-drill org-learn org-habit)))
 '(package-selected-packages
   (quote
    (mmm-mode markdown-toc markdown-mode gh-md julia-mode company-web auto-yasnippet ac-ispell helm-company helm-c-yasnippet fuzzy web-completion-data company-statistics company yasnippet auto-complete web-mode tagedit slim-mode scss-mode sass-mode pug-mode helm-css-scss haml-mode emmet-mode ox-reveal csv-mode ob-ipython dash-functional visual-fill-column org-drill-table org-mime org-ref pdf-tools key-chord ivy tablist helm-bibtex biblio parsebib biblio-core zotxt request-deferred deferred org-projectile org-category-capture org-present org-pomodoro alert log4e gntp org-download htmlize gnuplot ws-butler winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline powerline restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox spinner org-plus-contrib org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint info+ indent-guide hydra hungry-delete hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-projectile helm-mode-manager helm-make projectile pkg-info epl helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido flx fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg undo-tree eval-sexp-fu highlight elisp-slime-nav dumb-jump f dash s diminish define-word column-enforce-mode clean-aindent-mode bind-map bind-key auto-highlight-symbol auto-compile packed aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line helm avy helm-core popup async)))
 '(safe-local-variable-values
   (quote
    ((org-export-initial-scope . buffer)
     (org-export-initial-scope . subtree)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-done ((t (:foreground "#86dc2f" :height 1.0))))
 '(org-scheduled-today ((t (:foreground "#bc6ec5" :height 1.0)))))
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-sorting-strategy
   (quote
    ((agenda ts-up habit-down priority-down category-keep)
     (todo priority-down category-keep)
     (tags priority-down category-keep)
     (search category-keep))))
 '(org-agenda-window-setup (quote current-window))
 '(org-modules (quote (org-bibtex org-drill org-learn org-habit)))
 '(package-selected-packages
   (quote
    (flyspell-correct-helm flyspell-correct auto-dictionary mmm-mode markdown-toc markdown-mode gh-md julia-mode company-web auto-yasnippet ac-ispell helm-company helm-c-yasnippet fuzzy web-completion-data company-statistics company yasnippet auto-complete web-mode tagedit slim-mode scss-mode sass-mode pug-mode helm-css-scss haml-mode emmet-mode ox-reveal csv-mode ob-ipython dash-functional visual-fill-column org-drill-table org-mime org-ref pdf-tools key-chord ivy tablist helm-bibtex biblio parsebib biblio-core zotxt request-deferred deferred org-projectile org-category-capture org-present org-pomodoro alert log4e gntp org-download htmlize gnuplot ws-butler winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline powerline restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox spinner org-plus-contrib org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint info+ indent-guide hydra hungry-delete hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-projectile helm-mode-manager helm-make projectile pkg-info epl helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido flx fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg undo-tree eval-sexp-fu highlight elisp-slime-nav dumb-jump f dash s diminish define-word column-enforce-mode clean-aindent-mode bind-map bind-key auto-highlight-symbol auto-compile packed aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line helm avy helm-core popup async)))
 '(safe-local-variable-values
   (quote
    ((org-export-initial-scope quote buffer)
     (org-export-initial-scope . buffer)
     (org-export-initial-scope . subtree)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-done ((t (:foreground "#86dc2f" :height 1.0))))
 '(org-scheduled-today ((t (:foreground "#bc6ec5" :height 1.0)))))
)
