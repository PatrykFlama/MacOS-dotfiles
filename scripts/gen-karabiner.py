#!/usr/bin/env python3
# Regenerate config/karabiner/karabiner.json from the ctrl-alt-* bindings in
# config/aerospace/aerospace.toml. Usage (repo root): python3 scripts/gen-karabiner.py
# Only the rules are replaced; other settings in karabiner.json (GUI, keyboard type) are kept.
import json, re, sys
toml_path = sys.argv[1] if len(sys.argv) > 1 else "config/aerospace/aerospace.toml"
out_path = sys.argv[2] if len(sys.argv) > 2 else "config/karabiner/karabiner.json"
names = {"enter": "return_or_enter", "minus": "hyphen", "equal": "equal_sign",
         "slash": "slash", "comma": "comma", "semicolon": "semicolon", "tab": "tab"}
keys = []
for line in open(toml_path):
    m = re.match(r"ctrl-alt-(?:shift-)?([a-z0-9]+)\s*=", line)
    if not m: continue
    k = m.group(1)
    if k in ("left", "right", "up", "down"): continue  # keep ⌥+arrows = word jump
    k = names.get(k, k)
    if len(k) > 1 and k not in names.values(): sys.exit(f"unmapped key {k}")
    if k not in keys: keys.append(k)
manip = [{
    "type": "basic",
    "from": {"key_code": k, "modifiers": {"mandatory": ["left_option"], "optional": ["shift"]}},
    "to": [{"key_code": k, "modifiers": ["left_control", "left_option"]}],
} for k in keys]
# Extra hand-written rules (kept here so regenerating doesn't drop them).
# Left Option only: right Option + Space happens while typing Polish ("ą ")
# and must keep typing a (non-breaking) space, not open Spotlight.
extra_rules = [{
    "description": "Left Option + Space -> Command + Space (Spotlight)",
    "manipulators": [{
        "type": "basic",
        "from": {"key_code": "spacebar", "modifiers": {"mandatory": ["left_option"]}},
        "to": [{"key_code": "spacebar", "modifiers": ["left_command"]}],
    }],
}]

# ISO keyboard: the key between left Shift and Z becomes a second left Shift
# (ISO's left Shift is short). On Apple ISO keyboards that key reports
# grave_accent_and_tilde (checked in Karabiner-EventViewer); the top-left key
# (non_us_backslash) is untouched and still types ` and ~.
extra_rules.insert(0, {
    "description": "ISO: key next to left Shift -> left Shift",
    "manipulators": [{
        "type": "basic",
        "from": {"key_code": "grave_accent_and_tilde", "modifiers": {"optional": ["any"]}},
        "to": [{"key_code": "left_shift"}],
    }],
})

# Launchers + tiling toggle. These live in Karabiner (not AeroSpace) so they keep
# working while tiling is switched off. Commands run via /bin/sh.
def launcher(key, shift, cmd):
    mods = ["left_option"] + (["shift"] if shift else [])
    return {"type": "basic",
            "from": {"key_code": key, "modifiers": {"mandatory": mods}},
            "to": [{"shell_command": cmd}]}

extra_rules.insert(0, {
    "description": "Left Option launchers (terminal, Finder, yazi, cheatsheet, tiling toggle)",
    "manipulators": [
        launcher("return_or_enter", False, "open -na Ghostty"),
        launcher("f", False, "open ~"),
        launcher("f", True, "open -na Ghostty --args -e zsh -lic yazi"),
        launcher("slash", True, "open -na Ghostty --args --title=Keybindings -e zsh -lic "
                                "'glow -p \"$DOTFILES/docs/keybindings.md\"'"),
        launcher("t", True, "/etc/profiles/per-user/$USER/bin/tiling-toggle"),
    ],
})
rules = [{
    "description": "Left Option + AeroSpace keys -> Ctrl+Option (right Option stays for Polish letters)",
    "manipulators": manip,
}]
# Launchers first: Karabiner uses the first matching rule, and the generic rule
# above also matches shift (e.g. ⌥⇧/ must open the cheatsheet, not ⌃⌥⇧/).
rules = extra_rules + rules
# Keep whatever Karabiner/GUI stored (keyboard type, devices, settings);
# only the selected profile's complex_modifications.rules are replaced.
try:
    cfg = json.load(open(out_path))
except (FileNotFoundError, json.JSONDecodeError):
    cfg = {"profiles": [{"name": "Default", "selected": True}]}
profile = next((p for p in cfg["profiles"] if p.get("selected")), cfg["profiles"][0])
profile.setdefault("complex_modifications", {})["rules"] = rules
json.dump(cfg, open(out_path, "w"), indent=4, ensure_ascii=False)
print(len(keys), "keys:", " ".join(keys))
