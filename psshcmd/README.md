# Parallel SSH Command

## What is it?

This is a utility to remotely connect to multiple hosts, over ssh, and issue a
command. It will capture the exit status of the command and return the results
on stdout.

## Install Requirements

```
brew install libssh2
brew install crystal
shards install
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

## Testing

To run the included tests:

```
make test
```


## Usage

The command psshcmd reads a list of hosts from stdin and uses ssh credentials stored in environment variables for authentication. It will connect to each host in the list in parallel and any arguments after psshcmd will be passed as a command to the remote host. No output will be collected, only the exit value. What did you expect for 32 lines? This can still be useful for running commands that you only need to see their exit status.


### Examples

Create a hosts.txt file:
```
host1.example.com
host2.example.com
```

Password Authentication:

```
export SSH_USER=testuser
export SSH_PASS=$(read -s -p "Password: " password; echo $password)
```

Public Key Authentication:
```
export SSH_USER=testuser
export SSH_PRIVKEY=$HOME/.ssh/id_rsa
export SSH_PRIVKEY=$HOME/.ssh/id_rsa.pub
```

If your private key has passphrase:
```
export SSH_KEYPASS=$(read -s -p "Password: " password; echo $password)
```

Run some commands:

```
cat hosts.txt | psshcmd uptime
cat hosts.txt | psshcmd false
cat hosts.txt | psshcmd true
cat hosts.txt | psshcmd exit 15
cat hosts.txt | psshcmd sudo chef-client
```
