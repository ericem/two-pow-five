# TMUX Pane Stats (panestats)

## What is it?

This is a utility that when called, will output the proper formatting commands to draw a tmux border pane. This is the border that is draw at the bottom of a pane. For those unfamiliar with tmux, it is a terminal multiplexer that divides a single terminal into multiple windows with each window capable of containing several vertical or horizontal splits called panes. This utility will display the following information in the border 1) current git branch with branch status in color (clean, unstaged, staged, ahead, behind), 2) the current Chef environment, and 3) the current Ruby version.

## Install Build Requirements

I decided to switch back to Crystal for tonights project. It is just such a compact and expressive language, I can get many more features out of the same lines of code than in other languages.

Install the compiler:

```
brew install crystal
```

## Compiling

To build a debug version:

```
make
```

To build a release version:

```
make release
```

To install the binary:
```
make install
```


## Usage

Generate pane border formatting:
```
panestats <pane_current_path> <pane_active> <pane_id>
```

Pane parameters supplied by TMUX:
```
pane_current_path - the current directory that the pane's shell is in
pane_active - bool that represents if the pane is active or not
pane_id - the unique id of the pane
```

Expected Output:

```
[ master #[fg=colour3]●#[fg=colour14]#[fg=colour9]●#[fg=colour14]] ( local) ( 2.5.1)
```

Which would be displayed like:
```
─── [ master ●●] ( local) ( 2.5.1) ──────────────
```

## TMUX Configuration

Add the following command to your tmux.conf to set the pane-border-format.

$HOME/.tmux.conf
```
set -g pane-border-format '#(panestats #{pane_current_path} #{pane_active} #{pane_id})'
```
To get the rbenv version in the panestats command requires a little bash foo. Create a PROMPT_COMMAND function that will be called each time the prompt is shown. Inside this function we set a tmux variable based on the Ruby rbenv version. This will be used by tmux when it calls panestats. This is needed because tmux only reads environment variables once when a session is created, therefore variables that change (like rbenv version) twould never get upated.

$HOME/.bashrc

```
PROMPT_COMMAND=_prompt
if  [ -n "$TMUX" ];  then
  function set_tmux_opt {
      tmux set -q "@$1_$TMUX_PANE" "$2"
    }
  function unset_tmux_opt {
      tmux set -u "@$1_$TMUX_PANE"
    }
  function get_tmux_opt {
      tmux show -v "@$1_$2"
  }
fi
_prompt() {
if  [ -n "$TMUX" ];  then
  if [ $( which rbenv) ]; then
    set_tmux_opt rbenv_version "$(rbenv version-name)"
  fi
fi
}
```
