{ lib, ... }:
let
  inherit (builtins) attrNames isAttrs readDir listToAttrs attrValues;

  inherit (lib) filterAttrs hasSuffix hasPrefix mapAttrs' nameValuePair removeSuffix;

  # mapFilterAttrs ::
  #   (name -> value -> bool )
  #   (name -> value -> { name = any; value = any; })
  #   attrs
  mapFilterAttrs = sieve: f: attrs: filterAttrs sieve (mapAttrs' f attrs);

  # Generate an attribute set by mapping a function over a list of values.
  genAttrs' = values: f: listToAttrs (map f values);

  # Make a nixpkgs module with an attrset of packages sets
  mkPackagesModule = sets: {
    options = {
      pkgsets = lib.mkOption {
        type = lib.types.attrs;
        description = ''
          An attribute set of package sets to be used.
        '';
      };
    };

    config = {
      pkgsets = sets;
    };
  };

in
{
  inherit mapFilterAttrs genAttrs';

  recImport = { dir, _import ? base: import "${dir}/${base}.nix" }:
    mapFilterAttrs
      (_: v: v != null)
      (n: v:
        if n != "default.nix" && hasSuffix ".nix" n && v == "regular"
        then
          let name = removeSuffix ".nix" n; in nameValuePair (name) (_import name)

        else
          nameValuePair ("") (null))
      (readDir dir);

  # Convert a list to file paths to attribute set
  # that has the filenames stripped of nix extension as keys
  # and imported content of the file as value.
  pathsToImportedAttrs = paths:
    genAttrs' paths (path: {
      name = removeSuffix ".nix" (baseNameOf path);
      value = import path;
    });

  # List files in directory that are not hidden
  readVisible = dir:
    filterAttrs
      (name: _: !(hasPrefix "." name))
      (readDir dir);

  inherit mkPackagesModule;

  # Wrapper to create a user home-manager module from its definition
  mkHM = config: usercfg: {
    imports = [
      usercfg
      ../user/core
      (mkPackagesModule config.pkgsets)
    ] ++ attrValues config.home-manager-default-modules;
  };
}
