# Pipe Some Data and Plot It (pipeplot)

## What is it?

The pipeplot utility reads time series data from stdin and the generates a plot (in PNG format) of the data every INTERVAL number of seconds. Since pipeplot also outputs the data to stdout, pipeplot can be inserted into the middle of any standard Unix data processing pipeline. For example, you can use the healthstatus utility to retrieve process metrics, then use awk to process the data, then pipeplot to plot it, and finally tee it to a log file for long term storage. The easiest way you've ever seen to generate an endless stream of plots from an endless stream of data!


## Install Using Homebrew

```
brew tap ericem/two-pow-five
brew install pipeplot
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

```p
make release
```

To build and install the binary:
```
make install
```

### Run Time Requirements

In addition to the build requirements, install the run time requirements.


```
brew install gnuplot
```

## Usage

The pipeplot doesn't require any arguments, and by default will parse data from stdin using the first column as the x-axis data time in RFC 3339 time format and the second column as the y-axis data.

Start pipeplot:

```
pipeplot
```

You must feed some data to pipeplot on stdin, for example using the healthstatus utility and plotting column 7 (memory usage in kbytes).

```
SLEEP=1 healthstatus http://www.example.com:3000/4522 | COLUMN=7 pipeplot 
```

You can set some plot options using environment variables. The title (TITLE), the y-axis title (YTITLE), and the basename of the png file (PNG).

```
SLEEP=1 healthstatus http://www.example.com:3000/4522 | COLUMN=7 TITLE='Safari Memory Usage' YTITLE='KBytes' pipeplot 

```

You can change how often plots are generated using the INTERVAL environment variable:

```
SLEEP=1 healthstatus http://www.example.com:3000/4522 | COLUMN=7 TITLE='Safari Memory Usage' YTITLE='KBytes' INTERVAL=60 pipeplot 
```
This would generate plots every 60 seconds using data generated on 1 second intervals.

## Examples

Here is an example of monitoring Safari CPU utilization while browsing the Internet:

```
SLEEP=1 healthstatus http://localhost:3000/4209 | awk '{print $1 " " $5;system("")}' | INTERVAL=60 TITLE='Safari CPU Utilization' YTITLE=Percent PNG=safari ./pipeplot | tee -a safari.dat
```

This shows how the output from healthstatus was edited using awk to display just the time and the cpu utilization columns. Note the usage of the system function in awk, which is necessary to have awk output data to stdout in real-time. Finally, the performance metrics are logged to a file using the tee command.
