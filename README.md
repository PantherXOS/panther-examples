# PantherX OS Example Configurations

## Included

- Sway VM (`desktop-os-sway.scm`)
- XFCE VM (`desktop-os-xfce.scm`)
- Minimal desktop, for your own customization (`desktop-os-minimal.scm`)

## Usage

Example:

```bash
guix system vm desktop-os-sway.scm
```

Run with:

```bash
$ /gnu/store/…-run-vm.sh -m 2048 -smp 2 -nic user,model=virtio-net-pci --enable-kvm
```

For testing, from the `panther` repo:

```bash
./pre-inst-env guix system vm ../panther-examples/desktop-os-sway.scm
```

## Guix(OS) vs PantherX OS

### System Configuration

It's relatively easy to migrate between PantherX OS and Guix; Here's how the system configuration differs:

```scheme
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

  (packages %px-desktop-packages)
  (services %px-desktop-services))

 #:open-ports '(("tcp" "ssh"))
 #:authorized-keys `(("root" ,(plain-file "panther.pub" %ssh-public-key))))
```

A guix config, basically excludes the first layer `px-desktop-os`:

```scheme
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

  (packages %px-desktop-packages)
  (services %px-desktop-services))
```

You will lose some of the convenience of PantherX OS such as:

- Default packages and services
- Convenience functions like `open-ports` and `authorized-keys`
- Included panther and nongnu channels

otherwise they should behave pretty much the same.