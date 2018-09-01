################################################################
# deleting ^M AKA carriage return
################################################################
query-replace Ctrl+q Ctrl+m

################################################################
# set the comment string for a session in emacs
################################################################
M-x set-variable
comment-start
<Return>
# (it will tab-complete)
"#"
<Return>

################################################################
# manually add a tab
################################################################
# see http://stackoverflow.com/questions/8973489/emacs-tab-not-working
# because of auto-indenting things in emacs, sometimes a tab won't be added.
Ctrl+q TAB
# will make sure a tab is inserted

################################################################
# remove blank lines
################################################################
# see https://www.masteringemacs.org/article/removing-blank-lines-buffer
M-x flush-lines RET ^$ RET

################################################################
# mouse events for a non-X11 window emacs session
################################################################
xterm-mouse-mod

################################################################
# emacs new line in a replace
################################################################
C-q C-j

################################################################
# case conversion
################################################################
# Convert region to lower case (downcase-region):
C-x C-l

# Convert region to upper case (upcase-region):
C-x C-u

################################################################
# copy and paste clipboard
################################################################
# install xsel (see below on installation)
sudo apt-get install xsel
(defun copy-to-clipboard ()
  (interactive)
  (if (display-graphic-p)
      (progn
        (message "Yanked region to x-clipboard!")
        (call-interactively 'clipboard-kill-ring-save)
        )
    (if (region-active-p)
        (progn
          (shell-command-on-region (region-beginning) (region-end) "xsel -i -b")
          (message "Yanked region to clipboard!")
          (deactivate-mark))
      (message "No region active; can't yank to clipboard!")))
  )

(defun paste-from-clipboard ()
  (interactive)
  (if (display-graphic-p)
      (progn
        (clipboard-yank)
        (message "graphics active")
        )
    (insert (shell-command-to-string "xsel -o -b"))
    )
  )

(global-set-key [f8] 'copy-to-clipboard)
(global-set-key [f9] 'paste-from-clipboard)

################################################################
# source changes in a .emacs file
################################################################
M-x load-file
# OR
M-x eval-buffer
# OR highlight change and then
M-x eval-region

################################################################
# Turn on C-x C-c C-v as cut, copy, and paste
################################################################
M-x cua-mode

################################################################
# indent backwards
################################################################
C-u -4 M-x indent-rigidly

# EASIER:
C-c > or C-c <

################################################################
# search for lines longer than N, do
################################################################
M-x occur RET C-u (N+1) .  RET

################################################################
# display variable VAR
################################################################
C-H v VAR RET

################################################################
# select rectangle
################################################################
C-x SPC

################################################################
# kill rectangle
################################################################
C-x r k

################################################################
# install package
################################################################
M-x package-install

################################################################
# search for a certain character
################################################################
C-s C-q <TAB>
C-q
# tells emacs to search for literally whatever character is typed in next.

################################################################
# switch to another window
################################################################
C-x o

################################################################
# split window
################################################################
C-x 3