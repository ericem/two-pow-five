# Track a Streak of Anything (streak)

## What is it?

This is a simple app that displays the calendar of the current month on the terminal with the days highlighted in green, if the days are found in a streaks log file. In the past I have used spreadsheets to track goals with streaks, like this summers #rwrunstreak from Runner's World. Now, with streak, it's easy to keep track of those goals right in the terminal.


## Install Build Requirements

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

### Streaks Log File

Streak reads streaks data from either the file referenced in the environment variable STREAKS_LOG or the default location:

```
$HOME/.local/log/streaks.log
```

### Streaks Log Format

The format of the streaks log file, is a file containg one date timestamp per line where the date is formatted in the RFC 2822 date format. The `date` utility can generate the proper timestamp using the `-R` option:

```
date -R
```

Here is an simple bash function that can be added to your $HOME/.bashrc file to create an entry:

```
mark-streak-done() {
  [ -d $HOME/.local/log ] || mkdir -p $HOME/.local/log
  date -R >> $HOME/.local/log/streaks.log
```

Then to mark a streak in the log:
```
mark-streak-done
```

### Update Streaks with Git Hook
I'm going to use streak to track my streak of 2^5 submissions. To automate this tracking, I've created a git pre-push hook:

.git/hooks/pre-push:
```
[ -d $HOME/.local/log ] || mkdir -p $HOME/.local/log
date -R >> $HOME/.local/log/streaks.log
exit 0
```

Now, everytime that I push to my two-pow-five repository, it will update my streaks log. It does not hurt anything to have multiple entries on the same day in the streaks log. 

### Displaying Streaks Calendar

To display the current month and streaks:

```
streak
```
Expected output:

```
   September 2019
Su Mo Tu We Th Fr Sa
 1  2  3  4  5  6  7
 8  9 10 11 12 13 14
15 16 17 18 19 20 21
22 23 24 25 26 27 28
29 30
```

The days with a streak marked in the log file will be highlighted in green. Now keep that 2^5 streak going!

