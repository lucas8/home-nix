{ config, pkgs, ... }:

{
  xdg.configFile."qmk/qmk.ini".text = ''
    [user]
    keyboard = ergodox_ez
    keymap = dwarfmaster
  '';
}
