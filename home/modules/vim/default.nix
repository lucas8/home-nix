{ pkgs, recdata, ... }:

let

  myplugins = import ./plugins.nix { inherit pkgs; };

  lib = import ../../../lib/lib.nix;

  mypkgs = import ./packages.nix { inherit pkgs; };

  unstable = import <nixos-unstable> { };

in {
  programs.neovim = {
    enable      = true;
    package     = mypkgs.neovim-nightly;
    withNodeJs  = true;
    withPython  = true;
    withPython3 = true;
    withRuby    = true;
    viAlias     = true;
    vimAlias    = true;

    extraPython3Packages = ppkgs: [ (mypkgs.python-tasklib ppkgs) ];

    extraConfig = builtins.readFile ./vimrc;
    plugins = with pkgs.vimPlugins; with myplugins; [
      # Apparence
      base16-vim-recent    # Base16 color schemes (fixed for neovim nightly)
      lightline-vim        # Status line
      base16-vim-lightline # Base16 color schemes for lightline

      # QOL
      vim-multiple-cursors # Brings multiple cursors to vim
      fzfWrapper
      fzf-vim              # Fuzzy finder for new files
      vim-gitgutter        # Display git information in the gutter
      sandwich             # Operations on sandwiched expressions (parens, brackets ...)

      # Intellisense
      coc # Generic intellisense engine

      # Languages
      vim-polyglot # Support for 144 languages
      coquille     # Coq support
      dhall-vim    # Dhall support

      # Org-mode lite
      vimwiki
      taskwiki
    ];
  };

  packages = with pkgs; [
    nodejs # For coc
  ];

  xdg.configFile."nvim/coc-settings.json".text =
    let cocConfig = import ./coc-config.nix { inherit pkgs; }; in lib.toJSON cocConfig;
}

