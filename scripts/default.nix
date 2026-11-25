# Scripts in this folder, installed as commands with their dependencies
# pinned (they work even if rg/fzf/ffmpeg aren't otherwise installed).
{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellApplication {
      name = "fsearch";
      runtimeInputs = with pkgs; [
        ripgrep
        fzf
        bat
      ];
      text = builtins.readFile ./fsearch;
    })
    (pkgs.writeShellApplication {
      name = "ghostty-window";
      text = builtins.readFile ./ghostty-window;
    })
  ];
}
