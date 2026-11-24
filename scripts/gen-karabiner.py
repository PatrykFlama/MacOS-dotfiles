#!/usr/bin/env python3
# Regenerate config/karabiner/karabiner.json from the ctrl-alt-* bindings in
# config/aerospace/aerospace.toml. Usage (repo root): python3 scripts/gen-karabiner.py
# Note: overwrites karabiner.json (incl. anything changed in the Karabiner GUI).
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
cfg = {"profiles": [{
    "name": "Default",
    "selected": True,
    "complex_modifications": {"rules": [{
        "description": "Left Option + AeroSpace keys -> Ctrl+Option (right Option stays for Polish letters)",
        "manipulators": manip,
    }]},
}]}
json.dump(cfg, open(out_path, "w"), indent=2, ensure_ascii=False)
print(len(keys), "keys:", " ".join(keys))
