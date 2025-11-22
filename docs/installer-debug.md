# Installer Debug Mode

Use `OMARCHY_DEBUG=1` when the installer is crashing or running headless (serial/QEMU). Debug mode removes the gum-based TTY UI, enables verbose bash tracing, and mirrors the install log with a simple `tail -F` so the console stays readable.

## Quick start
```
OMARCHY_DEBUG=1 ./install.sh
```
- Log: `/var/log/omarchy-install.log`
- Artifacts on failure: `/tmp/collectiveos-artifacts/` (collects `omarchy-install.log`, `pacman.log`, `archinstall/install.log` if present; files are world-readable for easy retrieval)

## Minimal, fast reproduction
```
OMARCHY_DEBUG=1 install/debug-lite.sh
```
Runs guards + logging + `preflight/pacman.sh` + `packaging/base.sh` only, keeping the surface small while still exercising the pacman path that has been crashing VMs.

## Headless / serial QEMU boot
Boot the ISO with serial console and no graphical window. Adjust paths/resources as needed.
```
qemu-system-x86_64 \
  -cdrom /path/to/release/omarchy-*.iso \
  -m 8G \
  -smp 4 \
  -enable-kvm \
  -serial stdio \
  -display none
```
Inside the live environment:
```
export OMARCHY_DEBUG=1
export OMARCHY_ONLINE_INSTALL=1   # if required for your run
cd ~/.local/share/omarchy
./install.sh                      # or: install/debug-lite.sh
```
(If you pass a kernel cmdline like `console=ttyS0,115200n8`, the serial output is cleaner, but not required for this pass.)

## What changes in debug mode?
- No gum menus, cursor juggling, or full-screen log viewer; output stays plain text.
- `run_logged` executes with `bash -x` for detailed trace output into the log.
- Live log mirroring uses `tail -F` instead of the animated TTY display.
- On any error/exit, logs and key artifacts are copied to `/tmp/collectiveos-artifacts/` with permissive perms for easy extraction.

