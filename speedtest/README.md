# Internet Speed Test (speedtest)

## What is it?

This is the command line version of the speedtest.net website. By default speedtest will use a speedtest.net website to check the download speed by requesting a 100 megabyte uncompressable file, and then output the measured throughput in mega-bits per second. You can also enable debug mode for more detailed statistics and change the download site, if required.


## Install Using Homebrew

```
brew tap ericem/two-pow-five
brew install speedtest
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


Start speedtest:

```
speedtest
```

Use a different speed test host:

```
SPEEDHOST=URL speedtest
```

### Examples

Check your speed:
```
speedtest
```

Expected output:
```
170.73 mbps
```
Change the speed host url:

```
SPEEDHOST=https://speed.hetzner.de/100MB.bin speedtest
```

Expected output:
```
48.88 mbps
```
