{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user = {
        name = "Hytkat";
        email = "hytkate@gmail.com";
      };
      init.defaultBranch = "main";
      url = {
        "git@github.com:".insteadOf = "gh:";
        "git@gitlab.com:".insteadOf = "gl:";
        "git@codeberg.org:".insteadOf = "cb:";
        "git@github.com:hytkat/".insteadOf = "me@gh:";
      };
      status = {
        branch = true;
        showStash = true;
        showUntrackedFiles = true;
      };
      rerere.enable = true;
      column.ui = "auto";
      branch.sort = "-committerdate";
    };
  };
}
