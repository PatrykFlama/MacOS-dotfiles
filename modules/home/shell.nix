{ dotfilesDir, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 100000;
      save = 100000;
      ignoreDups = true;
      ignoreSpace = true; # commands starting with a space are not saved
      share = true;
    };

    shellAliases = {
      # eza's module already provides ls/ll/la/lt; these are the extras.
      l = "eza -l";
      lta = "eza --tree --level=2 --long -a";
      ff = "fzf --preview 'bat --style=numbers --color=always {}'";

      gitlog = "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      gitamend = "git commit --amend --no-edit";

      # Apply the config. Same muscle memory as `nrs` on NixOS.
      drs = "sudo darwin-rebuild switch --flake ${dotfilesDir}";
      nrs = "drs";
      # Bump flake inputs (nixpkgs, nix-darwin, home-manager), then rebuild.
      dup = "nix flake update --flake ${dotfilesDir} && drs";
    };

    initContent = ''
      # Emacs-style line editing, with ctrl/option + arrows jumping words.
      bindkey -e
      bindkey '^[[1;5C' forward-word
      bindkey '^[[1;5D' backward-word
      bindkey '^[[1;3C' forward-word
      bindkey '^[[1;3D' backward-word
      bindkey '^[[H' beginning-of-line
      bindkey '^[[F' end-of-line
      bindkey '^[[3~' delete-char

      # Your old prompt, plus the current git branch.
      autoload -Uz vcs_info
      precmd() { vcs_info }
      zstyle ':vcs_info:git:*' formats ' %F{blue}(%b)%f'
      setopt PROMPT_SUBST
      PROMPT='%F{magenta}[%f%F{green}%n%f%F{magenta}@%f%F{cyan}%m%f%F{magenta}:%f%F{yellow}%~%f%F{magenta}]%f''${vcs_info_msg_0_} %(?.%F{green}.%F{red})%#%f '
    '';
  };

  home.sessionVariables = {
    DOTFILES = dotfilesDir;
  };
}
