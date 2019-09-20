# Jump Box

## What is it?

This is a utility that can be used in conjunction with an OpenSSH server and Docker containers to provide a secure but useful jumpbox or bastion host. It currently supports just two environments an Ansible (Python) environment and a Chef (Ruby) environment.  

## Build Requirements

You will need Docker installed on your host to build this project.

## Compiling

Since this application needs to run on a Linux host, it must also be built in the target Linux environment. To make development simpler, included is a Dockerfile for creating the build environment.

Build crystal-builder container:
```
make crystal-builder
```

To build a debug version, run make:

```
make
```

To build a release version:

```
make release
```


## Deployment Requirements

You will need an Ubuntu 18.04 Linux server, called the 'jumpbox'. You will need Docker installed on the jumpbox.

Create an ENV variable for the jumpbox on your development machine:


## Deployment

$HOME/.bashrc
```
JUMPBOX_HOST=192.168.99.99
```

As you long as your user has write permissions to the default install location you can use the deploy target:
```
make deploy
```
If for some reason, this doesn't work, then use your favorite method to copy the jumpbox binary to the jumpbox server:

```
/usr/loca/bin/jumpbox
```

On the jumpbox, edit your Openssh config /etc/ssh/sshd_config:

```
Match Group jumpbox
  AllowTcpForwarding no
  PermitTunnel no
  X11Forwarding no
  PermitTTY yes
  ForceCommand /usr/local/bin/jumpbox
```

Add your users to the jumpbox group:

```
adduser johnnhy jumpbox
```

## Usage

Login to the jumpbox with your jumpbox username and provide an environment name:

```
ssh -t johnny@jumpbox.example.com <environment>
```
Note: You must supply the -t option to force creation of a tty on the server, since this uses the ForceCommand option which does not create a tty.

Currently, only two environments are provided ansible, and chef.

Expected Output:
```
Starting ansible environment
bash-5.0$
```
## Environments

I've provided the Dockerfiles for two test environments ansible and chef. I've also provided pre-built versions on the Docker hub.

Run the ansible environment:
```
docker run -it jumpox/ansible
```

Run the chef environment:
```
docker run -it jumpox/chef
```
