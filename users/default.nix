{ homeManagerConfiguration, finalHMModules, pkgs, ... }:

let

  inherit (pkgs) lib;

  mkConfig = path:
    { imports = [ path lib.profiles.core ] ++ builtins.attrValues finalHMModules; };

  configurations = {
    luc        = {
      username = "luc";
      config   = mkConfig ./luc.nix;
    };
    luc-server = {
      username = "luc";
      config   = mkConfig ./luc-server.nix;
    };
    luc-rpi4 = {
      username = "luc";
      config   = mkConfig ./luc-rpi4.nix;
    };
    luc-persist = {
      username = "luc";
      config   = mkConfig ./luc-persist.nix;
    };
  };

  mkHm = name: config:
    homeManagerConfiguration {
      configuration = config.config;
      system = "x86_64-linux";
      homeDirectory = "/home/${config.username}";
      username = config.username;
      stateVersion = "21.11";
      inherit pkgs;
    };

  activations = builtins.mapAttrs mkHm configurations;

in activations // { configurations = builtins.mapAttrs (_: config: config.config) configurations; }
