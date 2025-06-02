;; PantherX OS System Configuration File
;;
;; Author: Franz Geffke <m@f-a.nz>
;; Version: 3.0.0
;;
;; SWAY Desktop Environment for QEMU/KVM Virtual Machines

(use-modules (gnu)
             (gnu system)
             (px system panther)
       
             ;; swaylock-effects
             (gnu packages wm))

(use-service-modules xorg)

(operating-system
 (inherit %panther-os)
 (host-name "px-base")
 (timezone "Europe/Berlin")
 (locale "en_US.utf8")
 
 (bootloader
  (bootloader-configuration
   (bootloader grub-bootloader)
   (targets '("/dev/vda"))))
 
 (file-systems
  (cons
   (file-system
    (device (file-system-label "my-root"))
    (mount-point "/")
    (type "ext4"))
   %base-file-systems))
 
 (users
  (cons
   (user-account
    (name "panther")
    (comment "panther's account")
    (group "users")
    ;; Set the default password to 'pantherx'
    ;; Important: Change with 'passwd panther' after first login
    (password (crypt "pantherx" "$6$abc"))
    (supplementary-groups '("wheel" "audio" "video"))
    (home-directory "/home/panther"))
   %base-user-accounts))
 
 (services
  (cons*
   (service screen-locker-service-type
            (screen-locker-configuration
             (name "swaylock")
             (program (file-append
                       swaylock-effects
                       "/bin/swaylock"))
             (using-pam? #t)
             (using-setuid? #f)))
   
   (service greetd-service-type
            (greetd-configuration
             (greeter-supplementary-groups
              (list "video" "input" "users"))
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
   
   %panther-desktop-services-minimal))

 (packages 
  (cons* sway
  %panther-desktop-packages)))
