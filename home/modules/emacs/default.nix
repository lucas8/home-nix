general@{ lib, recdata, ... }:

let

  unstable = general.pkgs.nixpkgs.nixos-unstable;

  pkgs = general.pkgs.main;

  all-hies-gen = general.pkgs.hies;
  all-hies = all-hies-gen.selection { selector = p: { inherit (p) ghc865 ghc864 ghc863; }; };

in {
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: with epkgs; [
      evil
      evil-surround
      base16-theme
      smooth-scrolling
      lsp-mode
      lsp-ui
      lsp-haskell
      epkgs.general
      nix-mode
      helm
      hledger-mode
      company
      company-lsp
      idris-mode
      helm-idris
      proof-general
      company-coq
      projectile
      helm-projectile
      magit
    ];
  };

  home.file.".emacs".source = ./home.el;

  xdg.configFile."emacs/main.el".source = ./main.el;
  xdg.configFile."emacs/nixpaths.el".text = ''
    (setq nix/hie-wrapper "${all-hies}/bin/hie-wrapper")
    (setq nix/figlet "${pkgs.figlet}/bin/figlet")
    (setq nix/curl "${pkgs.curl}/bin/curl")
    (setq nix/coqtop "${pkgs.coq}/bin/coqtop")
  '';
}

