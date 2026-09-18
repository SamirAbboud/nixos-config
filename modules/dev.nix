{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Core Dev Tools
    neovim
    tree-sitter
    ripgrep

    # Nix
    nil
    alejandra

    # Lua
    lua-language-server
    stylua

    # Shell
    bash-language-server
    shfmt
    shellcheck
    fish-lsp

    # C / C++
    clang-tools
    gcc
    gnumake
    cmake
    perl

    # Rust & Go & Zig
    rustup
    go
    gopls
    gotools
    zig
    zls

    # Python
    pyright
    (python3.withPackages (ps: with ps; [
      psutil
      black
      isort
      autoflake
    ]))

    # Node / PHP
    fnm
    php
    intelephense
    phpPackages.composer

    # HTML, CSS, JSON Language Servers & Formatter
    vscode-langservers-extracted
    prettierd

    # JS/TS, Vue, Tailwind LSPs
    vtsls
    vue-language-server
    tailwindcss-language-server

    # Blade & Liquid Tooling
    blade-formatter
    shopify-cli

    # YAML & Markdown Language Servers
    yaml-language-server
    marksman
  ];
}
