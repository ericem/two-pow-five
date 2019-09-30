# TLS Certificate Verifier (certverify)

## What is it?

This utility will examine a certifiate chain and a host certifcate to verify that the host certificate is valid. This utility is a companion to the certdump utility and only requires a hostname instead of the full path names for the certificate chain and certifiate. 


## Install Using Homebrew

To install the binary version of certverify, first use use Homebrew to add the tap for my 2^5 projects and then install certverify. 

```
brew tap ericem/two-pow-five
brew install certverify
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


Verify a host certificate using a certificate chain:

```
certverify <certificate-chain> <certificate>
```

If you have already downloaded the certificates using the the certdump utility, you can use the shortcut method:

```
certverify hostname
```

This will be converted to the equivalent command:

```
certverify hostname.chain.pem hostname.cert.pem
```


### Examples

If you have already run `certdump www.example.com`:
```
certverify www.example.com
```

Manually specificy the files:
```
certverify www.example.com.chain.pem www.example.com.cert.pem
```
