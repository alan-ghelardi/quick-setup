(defconst my-emacspeak-src-dir "{{emacspeak-dir}}")

(defconst my-emacspeak-speech-server "{{speech-server}}")

(defconst my-emacspeak-speech-language "en-us")

(defconst my-emacspeak-speech-rate 400)

(defconst my-emacspeak-sound-theme "3d/")

(add-to-list 'load-path my-emacspeak-src-dir)

(setq dtk-program my-emacspeak-speech-server)

(add-hook 'emacspeak-startup-hook
          (lambda ()
            (dtk-set-language my-emacspeak-speech-language)
            (dtk-set-rate my-emacspeak-speech-rate 1)
            (emacspeak-sounds-select-theme my-emacspeak-sound-theme)))

(load-file (concat my-emacspeak-src-dir "/lisp/emacspeak-setup.el"))

(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/"))

(setq package-archive-priorities
      `(("melpa" . 20)
        ("gnu" . 10)
        ("melpa-stable" . 0)))

(package-initialize)
