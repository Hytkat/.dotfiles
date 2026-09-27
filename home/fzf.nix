{
  programs.fzf = {
    enable = true;
    # enableFishIntegration = true; --> handled by fzf.fish plugin.
    defaultCommand = "fd --hidden --strip-cwd-prefix --exclude .git";
    changeDirWidget.command = "fd --type=d --hidden --strip-cwd-prefix --exclude .git";
    changeDirWidget.options = [ "--preview 'eza --tree --color=always {} | head -200'" ];
    fileWidget.command = "fd --hidden --strip-cwd-prefix --exclude .git";
    fileWidget.options = [ "--preview 'bat --color=always -n --line-range :500 {}'" ];
  };
}
