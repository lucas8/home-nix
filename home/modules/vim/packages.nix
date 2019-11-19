{ pkgs, ... }:

{
  # Made it works thanks to https://github.com/gloaming/nixpkgs/tree/feature/nightly-neovim
  neovim-nightly = 
    let
      pkgs = import <nixos-unstable> {};
    in pkgs.neovim;

  python-tasklib = ppkgs: with ppkgs;
    let
      wsl_stub = pkgs.writeShellScriptBin "wsl" "true";
    in buildPythonPackage rec {
      pname = "tasklib";
      version = "1.2.1";
      src = fetchPypi {
        inherit pname version;
        sha256 = "3964fb7e87f86dc5e2708addb67e69d0932534991991b6bae2e37a0c2059273f";
      };
      propagatedBuildInputs = [
        six
        pytz
        tzlocal
      ];
      checkInputs = [
        pkgs.taskwarrior
        wsl_stub
      ];
      meta = with pkgs.lib; {
        homepage = https://github.com/robgolding/tasklib;
        description = "A library for interacting with taskwarrior databases";
        maintainers = with maintainers; [ arcnmx ];
        platforms = platforms.all;
        license = licenses.bsd3;
      };
    };
}

