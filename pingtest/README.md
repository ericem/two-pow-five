# Ping Test (pingtest)

## What is it?

The pingtest utitliy is designed to work with the speedtest app. It will send 5 ICMP echo request messages to a ping host and then average the results. By default, the ping host is set to be the same host used for the Internet speed tests. With the two applications compbined, one can get a yardstick measure of the quality of an current Internet connection in a very quick and simple manner.


## Install Using Homebrew

```
brew tap ericem/two-pow-five
brew install pingtest
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


Start a ping test to the default ping host:

```
pingtest
```

Start a ping test and use a different ping host:

```
PINGHOST=HOSTNAME pingtest
```

Change the defalt timeout (useful for a slow ping host) in seconds:
```
TIMEOUT=3 pingtest
```


### Examples


Start a ping test:

```
pingtest
```

Expected output:
```
30.933 ms
```

Use default gateway as a ping host:
```
PINGHOST="$(netstat -rn -f inet | grep default | awk {'print $2}')" pingtest
```
