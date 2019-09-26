# Battery Status for the Terminal

## What is it?

In a typical day I spend the majority of my time in the terminal, and when I'm not at my desk (and plugged into a monitor), I have the terminal in fullscreen mode to maximize those pixels. However, when I'm in fullscreen mode, it's easy to forget about the battery and how just how close to death it may be. This is a tiny utility to solve that problem. It simply prints out the current battery level and an icon depicting the charging status. You can then use this in scripts to display the current level in a nicely formatted way. I've included an example of how I'm going to use this in my tmux status. 

## Install Build Requirements

Install the compiler:

```
brew install nim
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

## Install Nerd Fonts

The icons in the battstat are from the Nerd Fonts. See (Nerd Fonts)[https://www.nerdfonts.com/#home] for more information. You can install them using Homebrew or directly from Nerd Fonts.

## Usage

View current battery level:
```
battstat
```

Expected output:
```
 70%
```

I have put battstat in my tmux configuration for the status bar. Here is my status-right setting which includes battstat.

$HOME/.tmux.conf:
```
set -g status-right  ' #S #(battstat) %l:%M %p'
```

The default refresh interval is every 30 seconds, you can shorten this to get a quicker battery status update when you go from AC to Battery.

$HOME/.tmux.conf
```
set -g status-interval 1
```
