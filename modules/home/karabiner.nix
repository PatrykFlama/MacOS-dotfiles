# Karabiner-Elements rules, generated on every `drs` from the per-host choices in
# flake.nix (window manager, keyboard), by scripts/gen-karabiner.py.
#
# ~/.config/karabiner is a normal folder (not linked to the repo): Karabiner and its
# GUI write to karabiner.json themselves (settings, keyboard type, backups), so it's
# machine state. The generator only replaces the rules and keeps everything else.
{
  config,
  lib,
  pkgs,
  windowManager,
  keyboard,
  ...
}:
{
  home.activation.karabiner = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    run ${pkgs.python3}/bin/python3 ${../../scripts/gen-karabiner.py} \
      --window-manager ${windowManager} \
      --keyboard ${keyboard} \
      --aerospace-config ${../../config/aerospace/aerospace.toml} \
      --out ${config.xdg.configHome}/karabiner/karabiner.json
  '';
}
