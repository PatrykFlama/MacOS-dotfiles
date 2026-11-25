# CLI tools from nixpkgs. GUI apps live in modules/darwin/homebrew.nix.
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # core utils
    coreutils # GNU versions alongside the BSD ones (g-prefixed)
    fd
    ripgrep
    jq
    tree
    wget
    unzip
    ncdu

    # system / fun
    btop
    tmux # config is symlinked from config/tmux (no programs.tmux: it would write its own tmux.conf)
    fastfetch
    glow # render markdown in the terminal (keybindings cheatsheet)

    # media
    ffmpeg
    exiftool
    yt-dlp

    # dev
    uv # python: replaces the old venv/fix-python dance
    nodejs
    nixfmt
    nixd # nix language server
  ];

  # Tools with home-manager modules get shell integration for free.
  programs.fzf.enable = true; # ctrl-r history, ctrl-t files, alt-c dirs
  programs.zoxide.enable = true; # `z <partial dir name>`
  programs.bat.enable = true;
  programs.eza = {
    enable = true;
    icons = "auto";
    git = true;
    extraOptions = [ "--group-directories-first" ];
  };
  programs.yazi = {
    enable = true;
    shellWrapperName = "y"; # `y` opens yazi and cd's to where you quit
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.gh.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    # Pass home-manager's generated lua via a wrapper flag instead of writing
    # ~/.config/nvim/init.lua, which is ours (symlinked from config/nvim).
    sideloadInitLua = true;
    plugins = [ pkgs.vimPlugins.nvim-treesitter.withAllGrammars ];
  };
}
