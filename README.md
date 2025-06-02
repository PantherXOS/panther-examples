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

## Debugging

```bash
./pre-inst-env guix system vm ../panther-examples/panther-sway.scm
guix repl --load-path=. ../panther-examples/panther-sway.scm
```