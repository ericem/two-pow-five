# cerner_2^5_2019
require "colorize"
require "file_utils"
pane_current_path, pane_active?, pane_id = ARGV[0], ARGV[1].to_i, ARGV[2]
FileUtils.cd(pane_current_path)
status = ""
git_status = `git status --porcelain 2>/dev/null`.chomp
if $?.success?
  git_branch = `git branch --show-current 2>/dev/null`.chomp
  status += " [ #{git_branch} "
  staged = /^[AMRD]/m.match(git_status)
  unstaged = /^ [MTD]/m.match(git_status)
  untracked = /^\?\?/m.match(git_status)
  unmerged = /^UU/m.match(git_status)
  status += "#[fg=#{pane_active? == 1 ? "colour2" : "colour15"}]●#[fg=#{pane_active? == 1 ? "colour14" : "colour15"}]" if staged
  status += "#[fg=#{pane_active? == 1 ? "colour3" : "colour15"}]●#[fg=#{pane_active? == 1 ? "colour14" : "colour15"}]" if unstaged
  status += "#[fg=#{pane_active? == 1 ? "colour9" : "colour15"}]●#[fg=#{pane_active? == 1 ? "colour14" : "colour15"}]" if untracked
  if ! staged && ! unstaged && ! untracked
    status += "#[fg=#{pane_active? == 1 ? "colour2" : "colour15"}]✓#[fg=#{pane_active? == 1 ? "colour14" : "colour15"}]"
  end
  git_status = `git status --porcelain -b 2>/dev/null`
  ahead = /^##.*ahead/m.match(git_status)
  behind = /^##.*behind/m.match(git_status)
  status += "#[fg=#{pane_active? == 1 ? "colour14" : "colour15"}]↑#[fg=#{pane_active? == 1 ? "colour14" : "colour15"}]" if ahead
  status += "#[fg=#{pane_active? == 1 ? "colour14" : "colour15"}]↓#[fg=#{pane_active? == 1 ? "colour14" : "colour15"}]" if behind
  status += "]"
end
chef_env = `chefvm current 2>/dev/null`.chomp
status += " ( #{chef_env})" if $?.success?
rbenv_version = `tmux show -v @rbenv_version_#{pane_id}`.chomp
status += " ( #{rbenv_version})"
puts status + " " if ! status.empty?
