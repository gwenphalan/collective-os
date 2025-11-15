# CollectiveOS

CollectiveOS is a fork of [Omarchy](https://github.com/basecamp/omarchy).
Read more at [omarchy.org](https://omarchy.org/).

## Additional package sources

Besides the stock Arch Linux repositories and Omarchy’s own mirror, the installer now enables the [CachyOS binary repository](https://cachyos.org/) so ISO builds can pull third‑party packages such as DaVinci Resolve, Proton Mail, and Zen Browser.

## Building bundled AUR packages

Some defaults (e.g., `modrinth-app`, Proton utilities, legacy Qt5 components) ship as prebuilt binaries under `repos/local-aur/x86_64` so the ISO can install them offline. After changing `install/collectiveos-aur.packages`, run `scripts/build-local-aur.sh` and commit the regenerated repo contents so downstream builders can reuse them.

## License

CollectiveOS is released under the [MIT License](https://github.com/gwenphalan/collective-os/blob/master/LICENSE).
