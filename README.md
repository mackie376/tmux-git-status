# Tmux git status

Prints current pane git branch and uncommited changes (if available).

## Installation
### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

```
set -g @plugin 'mackie376/tmux-git-status'
```

Add `#{git_status}` to your `status-left`, `status-right` or `pane-border-format` tmux option:

```
set -g status-left "#{git_status}"
```

Hit `prefix + I` to fetch the plugin and source it.

### Manual installation

Clone the repo:

```
$ git clone https://github.com/mackie376/tmux-git-status ~/clone/path
```

Add this line to the bottom of `.tmux.conf`:

```
run-shell ~/clone/path/tmux-git-status.tmux
```

Add `#{git_status}` to your `status-left`, `status-right` on `pane-border-format` tmux option:

```
set -g status-left "#{git_status}"
```

Reload TMUX environment:

```
$ tmux source-file ~/.tmux.conf
```
