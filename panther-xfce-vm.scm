;; PantherX OS System Configuration File
;;
;; Author: Franz Geffke <m@f-a.nz>
;; Version: 3.0.0
;;
;; XFCE Desktop Environment for QEMU/KVM Virtual Machines

(use-modules (gnu)
             (gnu system)
             (px system panther)
             (gnu packages desktop))

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

 ;; Globally-installed packages.
 (packages %panther-base-packages)

 ;; Globally-activated services.
 (services
  (cons*
   (service xfce-desktop-service-type)
   %panther-desktop-services)))
