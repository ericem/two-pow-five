# System Stats Receiver

## What is it?

This is a utility that receives system performance metrics from a multicast channel and outputs them in a simple, parseable format to stdout. This stream of metric data can then be parsed and examined using standard unix utilities. Do one thing, and do it well! If you want to aggregate statistics across several nodes, just run the statsrecvr on one nodes and the statscast on the others. The stats from each node are prefixed with the nodes ip address.

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


### Examples

Start statscast:
```
./statsrecvr
```

Expected Output:


```
2019-09-18T03:43:29Z 192.168.1.105 processes_total 582
2019-09-18T03:43:29Z 192.168.1.105 processes_running 3
2019-09-18T03:43:29Z 192.168.1.105 cpu_user 9.9
2019-09-18T03:43:29Z 192.168.1.105 cpu_sys 23.86
2019-09-18T03:43:39Z 192.168.1.105 processes_total 582
2019-09-18T03:43:39Z 192.168.1.105 processes_running 2
2019-09-18T03:43:39Z 192.168.1.105 cpu_user 13.40
2019-09-18T03:43:39Z 192.168.1.105 cpu_sys 22.90
2019-09-18T03:43:50Z 192.168.1.105 processes_total 578
2019-09-18T03:43:50Z 192.168.1.105 processes_running 2
2019-09-18T03:43:50Z 192.168.1.105 cpu_user 6.47
2019-09-18T03:43:50Z 192.168.1.105 cpu_sys 22.35
```
