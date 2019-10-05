# Interface Stats (ifstats)

## What is it?

The ifstats utility displays the current network interface statistics in the upper-right corner of the terminal. It functions as an always visible, heads-up-display for throughput data. The ifstats utility was designed to work well with the speedtest utility. If you start the ifstats utility in the background, and then run a speedtest, you can observe the interface throughput in real-time.


## Install Using Homebrew

```
brew tap ericem/two-pow-five
brew install ifstats
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


Start ifstats in the background:

```
ifstats &
```

Note: You don't have to start ifstats in the backround, but it will block the terminal if you don't and you won't be able to run other commands.

Start ifstats listening on a specific interface:

```
IFACE=INTERFACE ifstats &
```

Note: If you don't specify a network interface name using the IFACE environment variable, ifstats will listen on the default interface.

### Examples


Start ifstats on the default interface:

```
ifstats &
```

Expected Output:

```
  mbps TX:    0.00 RX:    0.00
   pps TX:       1 RX:       1
```

Start ifstats on the Ethernet interface:

```
IFACE=en1 ifstats &
```

```
  mbps TX:    0.00 RX:    0.00
   pps TX:       1 RX:       1
```
