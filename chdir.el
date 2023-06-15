;;; chdir.el --- Allows emacs to change /proc/self/cwd with (default-directory)

;; Author: Animesh Sahu <animeshsahu19@yahoo.com>
;; URL: https://github.com/Animeshz/linux-desktop
;; Version: 0.1
;; Package-Requires: ((emacs "28.0"))

;; Code

(require 'chdir-core)

(add-variable-watcher 'default-directory
  (lambda (sym newval op where)
    (chdir--native-run newval)))

(provide 'chdir)
