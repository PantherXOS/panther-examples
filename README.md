# PantherX OS Example Configurations

From the `panther` repo:

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