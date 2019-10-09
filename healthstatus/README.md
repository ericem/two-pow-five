# Process Health Status (healthstatus)

## What is it?

The healthstatus utility works in conjunction with healthmon to display process metrics in real-time. Healthstatus connects to a healthmon instance and retrieves the metrics for a single process id, and then continues retrieving new data on a perioidic interval (be default 60 seconds). If the process that healthmon exits or is killed, healthmon will send a HTTP 404 message to healthstatus, and healthstatus will exit.  


## Install Using Homebrew

```
brew tap ericem/two-pow-five
brew install healthstatus
```

## Install From Source

### Install Build Requirements

Install the compiler:

```
brew install crystal
```

### Compiling

To build a debug version:

```
make
```

To build a release:

```
make release
```

To build and install the binary:
```
make install
```

## Usage

When you start healthstatus, you must specify the URL for a healthmon instance and the process id that you want to monitor.

Start healthstatus:
```
healthstatus URL/PID
```

By default healthstatus will continuosly make requests to the healthmon instance every 60 seconds. To change the interval between requests, set the SLEEP environment variable.

Change request interval:
```
SLEEP=1 healthstatus URL/PID
```

You can have healthstatus output the terminal bell ASCII sequence on the stderr by setting the ALERT environment variable to 'true'. What would this be good for? If you use tmux and have it set to monitor window activity, it can change the color of the window tab when it detects a bell. This makes it easy to monitor when the process dies or exits without constantly checking healthstatus.

Turn on alerts (terminal bell):
```
ALERT=true healthstatus URL/PID
```

### Examples

In this example, we will monitor the memory usage of the neovim process will editing the healthstatus source code.

Start healthmon:
```
healthmon
```

Find the process id for the neovim application (nvim):
```
ps | grep nvim
35565 ttys006    0:26.45 nvim healthstatus.cr
```

Start healthstatus with the nvim process id:
```
healthstatus http://localhost:3000/35565
```

Expected output:
```
2019-10-09T01:52:54Z 35565 2019-10-09T00:48:26Z 0d1h4m28s 0.0 0.1 12152
2019-10-09T01:53:54Z 35565 2019-10-09T00:48:26Z 0d1h5m28s 0.0 0.1 12152
2019-10-09T01:54:54Z 35565 2019-10-09T00:48:26Z 0d1h6m28s 1.3 0.1 12160
```

Close the nvim and observe healthstatus exit as well:
```
Error: the process does not exist or has already exited.
``` 

