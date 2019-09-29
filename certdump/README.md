# TLS Certificate Dumper (certdump)

## What is it?

This utility will connect to a TLS enabled server and retrieve the TLS certifcate of the host. It can also retrieve the full certifcate chain. By default the certifcate will be decoded and displayed in a human friendly text format. However, the PEM encoded version can be displayed as well.


## Install Using Homebrew

To install the binary version of certdump, first use use Homebrew to add the tap for my 2^5 projects and then install certdump. 

```
brew tap ericem/two-pow-five
brew install certdump
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

### Install Run Time Requirements

In addition to the build requirements, install the run time requirements.

```
brew install openssl
```

## Usage


Connect to a host and dump a certificate:

```
certdump hostname[:port]
```

You can change the 

### Examples

Dump the text formatted certificate for a host on a non-standard port:
```
certdump server.example.com:7777
```

Dump the PEM formatted certifcate:
```
FORMAT=pem certdump www.example.com > www.example.com.crt
```

Dump the CA Certificate chain:
```
FORMAT=chain certdump www.example.com > www.example.com.ca.crt
```
