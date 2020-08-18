general@{ lib, self, recdata, ... }:

let
  pkgs = general.pkgs.main;
in {
  programs.direnv = {
    enable = true;
    enableNixDirenvIntegration = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    stdlib = ''
pwd_hash=$(echo -n $PWD | ${pkgs.perl}/bin/shasum | cut -d ' ' -f 1)
direnv_layout_dir=$XDG_CACHE_HOME/direnv/layouts/$pwd_hash

use_flake() {
  watch_file flake.nix
  watch_file flake.lock
  eval "$(nix print-dev-env --profile "$(direnv_layout_dir)/flake-profile")"
}
'';
  };
}

