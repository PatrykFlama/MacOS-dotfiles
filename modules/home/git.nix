{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Patryk Flama";
        email = "51850536+PatrykFlama@users.noreply.github.com";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      rebase.autoStash = true;
      diff.algorithm = "histogram";
      merge.conflictStyle = "zdiff3";
    };
    ignores = [
      ".DS_Store"
      ".direnv/"
      ".envrc.local"
    ];
  };

  # Side-by-side, syntax-highlighted diffs.
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      line-numbers = true;
    };
  };
}
