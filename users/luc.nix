{ lib, ... }:

{
  imports = [ ./luc-common.nix ] ++ (builtins.attrValues {
    # System
    inherit (lib.profiles.system)
      android
      direnv
      encryption
      xdg
      templates
      network
    ;


    # Interface
    inherit (lib.profiles.interface)
      x11
      xmonad
      visualisation
      locking
      brightness
    ;


    # Programs
    inherit (lib.profiles.programs)
      firefox
      chromium
      emacs
      audio
      blender
      documents
      drawing
      engineering
      git-annex
      maps
      messaging
      multimedia
      neovim
      passwords
      games
      cheat
      vim
    ;

    # Data
    inherit (lib.profiles.data)
      mail
      photos
      music
      book
      papers
      accounting
      feeds
      wiki
      calendar
      nextcloud
      contacts
    ;

    # Languages
    inherit (lib.profiles.languages)
      agda
      andromeda
      coq
      cpp
      dedukti
      haskell
      idris
      java
      julia
      latex
      lean
      lua
      nix
      ocaml
      python3
      tools
      why3
    ;
  });
}
