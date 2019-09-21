# Jump Box Auth

## What is it?

This application works with the jumpbox utility from an earlier submission to provide a simple authentication service. In a typical jumpbox deployment, you do not want to have any local user accounts with shell access, therefore you need an external authentication service typically ldap with password authentication. The jumpauth application provides a way to authenticate users with public keys stored in a local database as an alternative to password authentication. With a few more lines, jumpauth could be extended to query an ldap database for public keys instead of the local database. 

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

You will need an Ubuntu 18.04 Linux server, called the 'jumpbox'. You will need Docker installed on the jumpbox as well as a Redis database installed on the jumpbox. 

## Docker

Follow instructions from the Docker website to get Docker installed. Once Docker is installed, jumpbox and jumpauth should automatically fetch the jumpbox containers. If not you can install them manually:

```
docker pull jumpbox/ansible
docker pull jumpbox/chef
```

### Redis

To install redis:
```
sudo apt-get install redis
```

## Deployment

Create an ENV variable for the jumpbox on your development machine:

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
/usr/sbin/jumpauth
```

On the jumpbox, edit your Openssh config /etc/ssh/sshd_config:

```
AuthorizedKeysCommand /usr/sbin/jumpauth get %u
AuthorizedKeysCommandUser jumpauth
```

If you followed the instructions from the jumpbox utility, comment or delete the following section.
```
Match Group jumpbox
  AllowTcpForwarding no
  PermitTunnel no
  X11Forwarding no
  PermitTTY yes
  ForceCommand /usr/local/bin/jumpbox
```

Create a user for the jumpauth application:

```
addgroup jumpauth
adduser --system --no-create-home --shell /usr/sbin/nologin --ingroup jumpauth jumpauth
```

Set permissions on the jumpauth binary:
```
sudo chown root:jumpauth /usr/sbin/jumpauth
sudo chmod 755 /usr/sbin/jumpauth
```

Restart the ssh service:
```
sudo systemctl restart sshd
```

## Usage


## Add User to Database

From the jumpbox set the key for a user:

```
sudo jumpauth set <username> 'command="/usr/local/bin/jumpbox" <ssh_key_type> <ssh_key> <comment/email>'
```

Example:
```
sudo jumpauth set johnny 'command="/usr/local/bin/jumpbox" ssh-ed25519 ASDFASQW3RNAUSEFOIAUHERWHL#KEFHIAL johnny@example.com'
```

## Unlock User

When you set the key for a user, the user is automatically locked until to prevent unintentional access. The user will need to be unlocked each time the key is changed.

To unlock the user:
```
sudo jumpauth unlock <username>
```

## Lock User

If you want to temporarily disable an account, lock the user:

```
sudo jumpauth lock <username>
```

## Delete User

If you want to fully delete a user and key from the database:
```
sudo jumpauth del <username>
```

## Get a User

IF you want to get the key for a user:
```
sudo jumpauth get <username>
```

## Login to the Jumpbox

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
sudo chmod 755 /usr/sbin/jumpauth
