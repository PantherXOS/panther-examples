;; PantherX OS Sway Configuration

(use-modules (gnu)
             (gnu system)
             ;;
             (guix packages)
             (guix git-download)
             (guix build-system meson)
             (gnu packages wm)
             (gnu packages freedesktop)
             (gnu packages gtk)
             (gnu packages web)
             (gnu packages xorg)
             (gnu packages xdisorg)
             (gnu packages pcre)
             (gnu packages linux)
             (gnu packages gl)
             (gnu packages pkg-config)
             (gnu packages man)
             ;;
             (px system config))

(define %ssh-public-key
  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP7gcLZzs2JiEx2kWCc8lTHOC0Gqpgcudv0QVJ4QydPg franz")

(px-desktop-os
 (operating-system
  (host-name "px-base")
  (timezone "Europe/Berlin")
  (locale "en_US.utf8")

  (bootloader (bootloader-configuration
               (bootloader grub-bootloader)
               (targets '("/dev/vda"))))
  
  (file-systems (cons (file-system
                       (device (file-system-label "my-root"))
                       (mount-point "/")
                       (type "ext4"))
                      %base-file-systems))

  (users (cons (user-account
                (name "panther")
                (comment "panther's account")
                (group "users")
                ;; Set the default password to 'pantherx'
                ;; Important: Change with 'passwd panther' after first login
                (password (crypt "pantherx" "$6$abc"))
                (supplementary-groups '("wheel"
                                        "audio" "video"))
                (home-directory "/home/panther"))
               %base-user-accounts))

  (packages %px-desktop-minimal-packages)

  (services (cons*
      (service greetd-service-type
             (greetd-configuration
             (greeter-supplementary-groups (list "video" "input"))
              (terminals
              (list
		            (greetd-terminal-configuration
                 (terminal-vt "1")
                 (terminal-switch #t)
                 (default-session-command
                            (greetd-wlgreet-sway-session)))

                (greetd-terminal-configuration
                 (terminal-vt "2"))
                (greetd-terminal-configuration
                 (terminal-vt "3"))
                (greetd-terminal-configuration
                 (terminal-vt "4"))
                (greetd-terminal-configuration
                 (terminal-vt "5"))
                (greetd-terminal-configuration
                 (terminal-vt "6"))))))
  
  %px-desktop-minmal-services)))

 #:open-ports '(("tcp" "ssh"))
 #:authorized-keys `(("root" ,(plain-file "panther.pub" %ssh-public-key))))
