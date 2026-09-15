# My NixOS Configuration

Declarative NixOS system and user configurations managed via **Nix Flakes** and **Home Manager**.

---

## Architecture Overview

* **OS / Layout:** NixOS on Btrfs subvolumes (`/@home`)
* **Core Tools:** Nix Flakes (`flake.nix`) & Home Manager (`home.nix`)
* **Desktop:** Hyprland with Lua module integration
* **Shell & Utilities:** Fish shell (`eza`, `zoxide`, `fzf`, `bat`, `htop`, `yazi`)
* **Typography:** Custom Fontconfig rules with Noto Kufi Arabic, JetBrains Mono, and JetBrainsMono Nerd Font
* **Development Workspace:** Neovim (Modular Lua setup), Rust, C/C++, Python, PHP, Go, and Node.js (`fnm`)

---

## Quick Usage

### Rebuild System
```fish
sudo nixos-rebuild switch --flake .
```

### Apply Home Manager Setup

```fish
home-manager switch --flake .
```

## Maintenance

Clean system generations and optimize the Nix store:

```fish
sudo nix-collect-garbage -d
nix-store --optimise
```

## Related Repositories

* [**dotfiles**](https://github.com/SamirAbboud/dotfiles) — Application configs, themes, and installer scripts.
* [**autowalls**](https://github.com/SamirAbboud/autowalls) — Rust wallpaper daemon.
* [**sfetch**](https://github.com/SamirAbboud/sfetch) — System information fetch tool.


