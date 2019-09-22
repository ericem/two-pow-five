# Web Console for Linux Kernel Messages (webcon)

## What is it?

When debugging Linux kernel boot issues, like device and driver problems, it's very useful to read the kernel log. Howevever, how do you read those log messages if the disk isn't working, the machine isn't booted to a shell, or you don't have terminal/serial port access (like in a cloud environment)? That's where webcon comes in handy. It receives kernel log messages sent over the LAN using udp packets and then re-broadcasts them over websockets to a browser. Kernel logs live-streamed in the browser, in color!


## Install Run-time Requirements

The websockets are handled by ttyd. Install it using Hombebrew:

```
brew install ttyd
```

## Install Build Requirements

Webcon is written in the Crystal language, install the compiler:

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

This will install the binary to /usr/local/bin which, should be on the $PATH, if not please add it.

## Configure Kernel Logging


## Logging on Running System

To turn on logging using the instructions below, you will need configfs already mounted on the filesystem. 

Set some variables according to your system. The LOCAL_IP and LOCAL_DEV are the IP address and network interface name of the Linux server that will be logging to webcon. The REMOTE_IP is the IP address of the webcon logging host. The REMOTE_MAC is the Ethernet MAC address of the webcon host. If you don't specify a MAC address, then the kernel will use the broadcast address, causing extra load on your network if you are logging serveral servers.

```
export LOCAL_IP=192.168.99.2
export LOCAL_DEV=eth0
export REMOTE_IP=192.168.99.3
export REMOTE_MAC=AA:BB:CC:DD:EE:FF
```

Make sure the netconsle kernel module is loaded:
```
modprobe netconsole
```

Create a netconsole 'target' by creating a directory in the configs:
```
WEBCON=/sys/kernel/config/netconsole/webcon
mkdir $WEBCON
cd $WEBCON
```

Set the netconsole parameters:
```
echo $LOCAL_IP > local_ip
echo $LOCAL_DEV > dev_name
echo $REMOTE_IP > remote_ip
echo $REMOTE_MAC > remote_mac
```

Enable logging:
```
echo 1 > enabled
```

Kernel messages are now being sent in UDP packets to the webcon host on port 6666, which is the default for the netconsole module. You may also want to increase logging verbosity to the highest level by setting the proper kernel sysctl.

Increase logging level:
```
sysctl -w kernel.printk="8 8 8 8"
```

## Logging At Boot

To configure kernel logging at boot, use the same parameters as described above, but add the following line to your boot configuration:

```
netconsole=LOCAL_IP/LOCAL_DEV,REMOTE_IP/REMOTE_MAC
```

The method for configuring boot parameters depends on your boot loader. Read the instructions for grub or syslinux, depending on your operating system.


## Usage


To start webcon on the default port (8888):

```
webcon
```

To view the log messages, open a browser and enter the url:

```
http://localhost:8888
```

If you need to use a different port for webcon use the WEBCON_PORT environment variable:

```
WEBCON_PORT=8080 webcon
```

If you want to use webcon without the brower, you can log kernel messages to a console using:

```
webcon receive
```

## Logging a Test Message

You can trigger a kernel log messages manually to test webcon.

Echo message to /dev/kmsg:

```
echo "Read this on a webcon" > /dev/kmsg
```

