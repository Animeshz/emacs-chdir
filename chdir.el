;;; chdir.el --- Allows emacs to change /proc/self/cwd with (default-directory)

;; Author: Animesh Sahu <animeshsahu19@yahoo.com>
;; URL: https://github.com/Animeshz/linux-desktop
;; Version: 0.1
;; Package-Requires: ((emacs "28.0"))

;; Code

(require 'chdir-core)

(defvar chdir--change-timer nil
  "Timer for a short duration so extremely fast variable updates don't produce concurrency issues")

(defun chdir-invoke ()
  (chdir--native-run (file-truename default-directory))
  (setq chdir--change-timer nil))

(defun chdir--watch-run (&optional sym newval op where)
  (when chdir--change-timer (cancel-timer chdir--change-timer))
  (setq chdir--change-timer (run-with-timer 0.5 nil #'chdir-invoke)))
(add-variable-watcher 'default-directory #'chdir--watch-run)
(add-hook 'buffer-list-update-hook #'chdir--watch-run)

(provide 'chdir)
