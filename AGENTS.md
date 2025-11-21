# CollectiveOS Agent Guide

## Project Overview
- CollectiveOS is Gwen’s personal fork of Omarchy. It is currently bit-for-bit identical to upstream Omarchy but will diverge quickly; treat upstream docs as reference, not truth.
- Scripts and paths are still namespaced as `omarchy` (e.g., expected install at `~/.local/share/omarchy`, state at `~/.local/state/omarchy`, logs at `/var/log/omarchy-install.log`). Preserve these until the fork intentionally renames them.

## Tech Stack & Layout
- Stack: Bash scripts, pacman package lists, Hyprland + Wayland desktop configs (waybar, mako, walker, swayosd, hyprlock), Chromium/Alacritty/Kitty/Neovim theme presets.
- Root layout:
  - `install/` – installer entrypoints (helpers, preflight guards, packaging, config, login, post-install) and package lists.
  - `bin/` – user-facing `omarchy-*` commands (updates, migrations, theming, installs, debugging, utilities).
  - `migrations/` – timestamped Bash snippets applied post-install by `omarchy-migrate`.
  - `config/` & `default/` – user/system config templates copied into place during install.
  - `themes/` – bundled theme sets (css/conf/backgrounds) for apps and Hyprland stack.
  - `applications/` & `autostart/` – desktop entries and autostart items.
  - `version` – current upstream version number (CollectiveOS currently tracks Omarchy here).

## Development Setup
- Work on **Vanilla Arch Linux x86_64** with Btrfs root, Limine bootloader installed, Secure Boot disabled, and no preinstalled GNOME/KDE; installer enforces these guards.
- Clone the CollectiveOS repo into the expected path and add binaries to PATH (substitute your fork URL as needed; upstream shown for reference):
```
git clone https://github.com/basecamp/omarchy.git ~/.local/share/omarchy
export PATH="$HOME/.local/share/omarchy/bin:$PATH"
```
- Optional quick installer (online mode sets logging/UX flags):
```
cd ~/.local/share/omarchy
./install.sh
```
- Install log tails live from `/var/log/omarchy-install.log` (permissions set by installer).

## Core Workflows
- **Installer flow**: `install.sh` chains helpers → preflight (`install/preflight/all.sh`) → package installs (`install/packaging/*.sh` reading `install/omarchy-*.packages`) → config copy and hardware tweaks (`install/config/*.sh`) → login stack setup → post-install steps.
- **Preflight guards**: `install/preflight/guard.sh` aborts if requirements not met; bypass only knowingly (gum prompt). Preflight also marks existing migrations as applied to avoid rerunning historical scripts on fresh installs.
- **Migrations**: `omarchy-migrate` runs pending scripts in `~/.local/share/omarchy/migrations`, recording state in `~/.local/state/omarchy/migrations` (skips tracked separately). Create new migration via `bin/omarchy-dev-add-migration` (uses last git commit timestamp for filename) and ensure idempotent, non-interactive behavior.
- **Updating configs/themes**: `bin/omarchy-refresh-*` scripts copy templates from `default/` and `config/` into system/user locations; theme workflows use `bin/omarchy-theme-*` and assets under `themes/`.
- **Package curation**: Edit `install/omarchy-base.packages` (core set) or `install/omarchy-other.packages` (ISO/optional) and adjust corresponding `install/packaging/*.sh` if behavior changes.
- **Debugging**: `bin/omarchy-debug` collects system info; failed installs surface a gum-driven error menu with upload/view-log options from `install/helpers/errors.sh`.

## Coding Conventions & Architecture Rules
- .editorconfig: UTF-8, LF, spaces, indent_size 2, trim trailing whitespace, final newline.
- Scripts commonly run with `set -eEo pipefail` (installer) and rely on sourced helpers; keep functions idempotent and avoid prompting unless routed through existing UX (gum).
- Assume repo lives at `~/.local/share/omarchy`; many paths are hardcoded. Keep new paths consistent or gate with env vars when necessary.
- Favor copy-then-overwrite patterns used in `install/config/*.sh` when writing new config deploy steps; respect user home permissions and avoid chmod/chown surprises.

## Dos and Don’ts for Agents
- Do test on a throwaway Arch VM; installer and refresh scripts modify `/etc`, pacman config, bootloader, and user dotfiles.
- Do use `run_logged` inside installer chains so actions are captured in the install log.
- Do keep migrations safe to re-run and short (many run without `set -e`; handle errors explicitly if needed).
- Don’t run the installer on non-Arch or non-Btrfs hosts; guards exist for a reason.
- Don’t rename or relocate `install/`, `bin/`, `config/`, `default/`, or `themes/` without reviewing all scripts that reference hardcoded paths.
- Don’t remove package entries casually; ISO/build tooling consumes the package lists.

## Tests / Quality Gates
- No automated tests or linters are present. Manual validation is via successful installer run, clean migrations, and desktop booting into Hyprland with theming intact.

## CI / CD Notes
- No CI/CD config found; issue templates only. Releases seem tracked via the `version` file and git tags/branches (installer defaults to `master`).

## Risky / Sensitive Areas
- Installer overwrites `/etc/pacman.conf`, mirrorlists, login manager configs (plymouth, sddm, limine), and copies numerous dotfiles; review before changing.
- Hardware scripts under `install/config/hardware/` tweak power buttons, suspend, NVIDIA/Mac/Suface quirks—alter carefully and test on matching hardware.
- Migrations and refresh scripts assume Wayland/Hyprland stack; changes can break session startup if configs mismatch installed package versions.

## Agent History

# OS0
- OS0's sole task was to analyze the codebase and generate this AGENTS.md file.