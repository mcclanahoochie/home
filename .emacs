;; user info
(setq
 user-full-name "Chris McClanahan"
 user-mail-address "chris@mcclanahoochie.com")

;; packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))
(setq package-list '(
                     auto-complete
                     yasnippet
                     auto-complete-c-headers
                     iedit
                     color-theme
                     multi-web-mode
                     ))

;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; ;; debug -- keep near top -- turn on when needed
;; (setq
;;  debug-on-error t                     ; enter debugger on errors
;;  stack-trace-on-error t               ; show backtrace of error on debug
;;  debug-on-quit nil                    ; don't debug when C-g is hit
;;  debug-on-signal nil                  ; don't debug any/every error
;;  )

;; save real estate.
(menu-bar-mode -1)
;(tool-bar-mode -1)
;(scroll-bar-mode -1)

;; tabs
(setq-default indent-line-function 4)
(setq-default tab-width 4)
(setq-default c-basic-offset 4)
(setq-default c++-basic-offset 4)
(setq tab-stop-list (number-sequence 4 200 4))

;; Default configuration
(setq
 ; show warning instead of following
 vc-follow-symlinks nil

 ; Remove the new line character
 kill-whole-line t

 ; No annoying messages
 initial-scratch-message nil
 inhibit-startup-message nil
 inhibit-splash-screen t
 garbage-collection-messages nil

 ; No more empty lines and spaces
 indicate-empty-lines t
 indicate-buffer-boundaries t

 ; No more beeping
 visual-bell t
 visible-bell t
 default-major-mode 'org-mode

 ; Formatting
 search-highlight t
 query-replace-highlight t
 require-final-newline t
 next-line-add-newlines nil         ; No new lines when scrolling down

 ; Scrolling
 scroll-step 1
 scroll-preserve-screen-position t
 scroll-margin 0
 next-screen-context-lines 0
 scroll-error-top-bottom t

 ; Case insensitive search
 case-fold-search t
 completion-ignore-case t
 read-file-name-completion-ignore-case t

 ; safety ?
 revert-without-query '("\\.log$")

 ; Backups
 ; http://stackoverflow.com/questions/2680389/how-to-remove-all-files-ending-with-made-by-emacs
 backup-directory-alist `(("." . "~/.emacs.d/backup"))
 backup-by-copying t
 delete-old-versions t
 kept-new-versions 5
 kept-old-versions 5

 ; Compilation commands
 compile-command "make -j4"
 compilation-scroll-output t
 compilation-read-command nil
 compilation-ask-about-save nil
 compilation-window-height nil
 compilation-process-setup-function nil

 ; system copy paste
 x-select-enable-clipboard t
 )

;; enable delete selection mode
(delete-selection-mode 1)
;; enable which-func-mode
(which-func-mode 1)

;; delete trailing whitespace before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; C and C++
(defun my-c-mode-common-hook ()
  "Custom C mode hooks. K&R style braces."
  (interactive)
  (c-set-style "k&r")
  (setq c-basic-offset 4)
  (setq c++-basic-offset 4)
  (setq-default indent-line-function 4)
  (setq-default tab-width 4)
  )

;; connect
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;; whitespace setting
(defun my-whitespace-hook ()
  "Show trailing whitespace."
  (setq
   show-trailing-whitespace t)
  )

;; connect
(add-hook 'c-mode-common-hook 'my-whitespace-hook)
(add-hook 'java-mode-hook 'my-whitespace-hook)
(add-hook 'f90-mode-hook 'my-whitespace-hook)
(add-hook 'go-mode-hook 'my-whitespace-hook)

; autoload elisp scripts
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)

;; Go mode
(autoload 'go-mode "go-mode"
  "Major mode for editing go language files" t)
(autoload 'gofmt-before-save "go-mode"
  "Run gofmt before saving" t)

;; file types
(add-to-list 'auto-mode-alist '("\\.cu$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cuh$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.inl$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cl$" . c++-mode))

(add-to-list 'auto-mode-alist '("\\.mk$" . makefile-mode))
(add-to-list 'auto-mode-alist '("Makefile\\." . makefile-mode))
(add-to-list 'auto-mode-alist '("CMakeLists\\.txt$" . cmake-mode))
(add-to-list 'auto-mode-alist '("\\.cmake$" . cmake-mode))

(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.txt$" . markdown-mode))

(add-to-list 'auto-mode-alist '("\\.conf$" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))
(add-to-list 'auto-mode-alist '("\\.go$" . go-mode))
(add-to-list 'auto-mode-alist '("\\.F90$" . fortran-mode))

(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'auto-mode-alist '("\\.pde$" . java-mode))

(add-to-list 'auto-mode-alist '("\\.glslf$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.glslv$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.fs$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.vs$" . c++-mode))

;; history
(savehist-mode 1)
(setq savehist-file "~/.emacs.d/history")

;; buffer nav
(defun switch-to-previous-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer)))

;; custom bindings
(defun my-custom-bindings ()
  "My custom bindings."
  (local-set-key "\C-c\C-c" 'compile)
  (local-set-key "\C-cc" 'comment-region)
  (local-set-key "\C-x\C-n" 'next-error)
  (local-set-key "\C-x\C-p" 'previous-error)
  (local-set-key "\C-x\C-l" 'switch-to-previous-buffer)
  )

;; connect
(add-hook 'c-mode-hook 'my-custom-bindings)
(add-hook 'c++-mode-hook 'my-custom-bindings)
(add-hook 'java-mode-hook 'my-custom-bindings)
(add-hook 'f90-mode-hook 'my-custom-bindings)
(add-hook 'emacs-lisp-mode-hook 'my-custom-bindings)
(add-hook 'sh-mode-hook 'my-custom-bindings)
(add-hook 'makefile-mode-hook 'my-custom-bindings)
(add-hook 'cmake-mode-hook 'my-custom-bindings)
(add-hook 'markdown-mode-hook 'my-custom-bindings)
(add-hook 'nxml-mode-hook 'my-custom-bindings)

;; auto completes code snippets
(require 'yasnippet)
(yas-global-mode 1)

;; general auto complete features
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)
(defun auto-complete-mode-maybe ()
  "No maybe for you. Only AC!"
  (unless (minibufferp (current-buffer))
    (auto-complete-mode 1)))

;; Enable auto-complete-c-headers for c, c++
(defun my-ac-c-header-init()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/usr/include")
  (add-to-list 'achead:include-directories '"/usr/include/c++/4.9.2")
  (add-to-list 'achead:include-directories '"/usr/include/c++/4.8")
  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-unknown-linux-gnu/4.9.2/include")
  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-linux-gnu/4.8/include")
  )

;; connect
(add-hook 'c++-mode-hook 'my-ac-c-header-init)
(add-hook 'c-mode-hook 'my-ac-c-header-init)

;; iedit
(define-key global-map (kbd "C-c ;") 'iedit-mode)

;; ============================================================================

;; mac key remap
(setq mac-option-modifier 'control)
(setq mac-command-modifier 'meta)

;; #if 0 ... #endif
(defun my-c-mode-font-lock-if0 (limit)
  (save-restriction
    (widen)
    (save-excursion
      (goto-char (point-min))
      (let ((depth 0) str start start-depth)
        (while (re-search-forward "^\\s-*#\\s-*\\(if\\|else\\|endif\\)" limit 'move)
          (setq str (match-string 1))
          (if (string= str "if")
              (progn
                (setq depth (1+ depth))
                (when (and (null start) (looking-at "\\s-+0"))
                  (setq start (match-end 0)
                        start-depth depth)))
            (when (and start (= depth start-depth))
              (c-put-font-lock-face start (match-beginning 0) 'font-lock-comment-face)
              (setq start nil))
            (when (string= str "endif")
              (setq depth (1- depth)))))
        (when (and start (> depth 0))
          (c-put-font-lock-face start (point) 'font-lock-comment-face)))))
  nil)
(defun my-c-mode-common-hook ()
  (font-lock-add-keywords
   nil
   '((my-c-mode-font-lock-if0 (0 font-lock-comment-face prepend))) 'add-to-end))

;; connect
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;; system path
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))
(when window-system (set-exec-path-from-shell-PATH))

;; vim style parenthesis match
(global-set-key "%" 'match-paren)
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))
(show-paren-mode 1)

;; SHIFT-arrow between windows
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; window opacity
(set-frame-parameter nil 'alpha 90)

;; font
;(set-default-font "-microsoft-Consolas-bold-bold-bold-*-15-*-*-*-m-0-iso10646-1")
;(set-default-font "-apple-Menlo-medium-normal-normal-*-14-*-*-*-m-0-iso10646-1")

;; astyle
(defun astyle-this-buffer (pmin pmax)
  (interactive "r")
  (shell-command-on-region
   pmin pmax
   "astyle --style=java --indent=spaces=4 --pad-oper --pad-header --unpad-paren --add-brackets --keep-one-line-blocks --keep-one-line-statements --align-pointer=type "
   (current-buffer) t
   (get-buffer-create "*Astyle Errors*") t))

;; option/ctrl  scroll zoom
(global-set-key [C-mouse-4] 'text-scale-increase)
(global-set-key [C-mouse-5] 'text-scale-decrease)

;; eshell
(defun my-eshell-setup ()
  "My eshell and pcomplete setup."
  (setq
   eshell-modify-global-environment t   ; export affects emacs
   eshell-ask-to-save-history 'always   ; save history silently
   eshell-cd-shows-directory nil        ; print dir after changing into
   eshell-default-target-is-dot t       ; default dir for cp,mv,ln is '.'
   eshell-prefer-lisp-functions nil
   eshell-plain-grep-behavior nil
   pcomplete-file-ignore nil            ; don't exclude any file completions
   pcomplete-dir-ignore nil             ; don't exclude any dir completions
   eshell-prefer-to-shell t             ; use eshell for M-!
   eshell-history-size 500
   eshell-scroll-show-maximum-output t  ; show max output
   eshell-scroll-to-bottom-on-output nil  ; don't scroll while browsing
   eshell-scroll-to-bottom-on-input t   ; scroll as soon as type
   eshell-output-filter-functions '(eshell-handle-control-codes
                                    eshell-watch-for-password-prompt
                                    eshell-postoutput-scroll-to-bottom)
   pcomplete-expand-before-complete nil ; expand as far as possible
   pcomplete-autolist nil               ; 1st TAB partial complete, 2nd list
   pcomplete-cycle-completions nil      ; always show list, no cycle
   pcomplete-cycle-cutoff-length 0      ; no exceptions to cycling
   pcomplete-use-paring nil             ; don't exclude any completions
   pcomplete-restore-window-delay 0
   pcmpl-gnu-tarfile-regexp
   "\\.t\\(ar\\(\\.\\(gz\\|bz2\\|Z\\)\\)?\\|gz\\|a[zZ]\\|z2\\)\\'"
   eshell-tar-regexp pcmpl-gnu-tarfile-regexp
   eshell-show-lisp-completions t
   eshell-modules-list   '(eshell-alias
                           eshell-basic
                           eshell-cmpl
                           eshell-dirs
                           eshell-glob
                           eshell-hist
                           eshell-ls
                           eshell-prompt
                           eshell-unix
                           eshell-smart
                           eshell-term
                           eshell-xtra)
   eshell-visual-commands '("vi"
                            "ssh"
                            "vim"
                            "screen"
                            "python2.6"
                            "top"
                            "gdb"
                            "matlab"
                            "less"
                            "ccmake"
                            "ipython2.6"))
  (local-set-key "\C-a" 'eshell-maybe-bol)
  (local-set-key "\C-ce" 'eshell-show-maximum-output)
  (local-set-key "\C-xw" 'w3m)
  (local-set-key "\C-xf" 'w3m-search)
  (local-set-key "\C-x\C-h" 'eshell)
  (local-set-key "\C-ct" 'matlab-shell))
(add-hook 'eshell-mode-hook 'my-eshell-setup)
(global-set-key "\C-x\C-h" 'eshell)

;; tramp ssh
(require 'tramp)
(setq
 tramp-default-method "ssh"
 tramp-verbose 9)

;; makefile
(add-to-list 'auto-mode-alist '("\\.mak$" . makefile-mode))
(add-to-list 'auto-mode-alist '("Makefile\\." . makefile-mode))
(defun my-makefile-mode ()
  (define-key makefile-mode-map "\C-c\C-c" 'compile))
(add-hook 'makefile-mode-hook 'my-makefile-mode)

;; cmake
(autoload 'cmake-mode "cmake-mode" nil t)
(add-to-list 'auto-mode-alist '("CMakeLists\\.txt$" . cmake-mode))
(add-to-list 'auto-mode-alist '("\\.cmake$" . cmake-mode))

;; modeline buffer list
(iswitchb-mode 1)
(setq
 iswitchb-max-to-show 7
 iswitchb-default-method 'samewindow)


;; put last so if anything goes wrong, emacs looks way different
;; color theme
(require 'color-theme)
(color-theme-initialize)
(color-theme-dark-laptop)
