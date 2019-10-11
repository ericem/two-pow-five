# Process Death Watch (deathwatch)

## What is it?

Sometimes you have one process that is killing another process on your server, and you just can't figure out who the assasin is. This utility will monitor for a process to receive a signal and then send a notification of the process death using Microsoft Flow (if a URL is provided). The deathwatch utility uses Linux eBPF and kernel probes to trap the system calls for signals. This utility, has only been tested on CentOS 7, using Vagrant, but should work on other Linux versions as long as the kernel versions are the same.


## Install From Source

This build process was tested using CentOS 7. A Vagrantfile is provided to assist testing and building.


### Install Build Requirements

Install the compiler:

```
curl https://dist.crystal-lang.org/rpm/setup.sh | sudo bash
```

Install Libraries:
```
yum install zlib-devel openssl-devel git bcc kernel-headers

```

Install Crytal Library Dependencies
```
shards install
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

### Run Time Requirements

In addition to the build requirements, install the run time requirements.


```
yum install bcc
```

## Usage


Start deathwatch and provide the process ID to monitor:

```
deathwatch PID
```

Start deathwatch and send a notification using Microsoft Flow:

```
FLOWURL=URL deathwatch PID
```


### Examples

