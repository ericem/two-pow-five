# System Stats Broadcaster

## What is it?

This is a utility that collects system performance metrics and broadcasts it as json data over a multicast channel every 10 seconds.

## Install Requirements

```
brew install crystal
```

## Compiling

To build a debug version, run make:

```
make
```

To build a release version:

```
make release
```


## Usage

Just start it up! If you want to check that it's working, open Wireshark and start a packet capture. You will see UDP packets on multicast channel 224.0.9.9 port 22499. You will have to wait for the statsreceiver in another 32 line snippet.

### Examples

Start statscast:
```
./statscast
```

Expected Output:


```

```
p.s. It doesn't display any output.
