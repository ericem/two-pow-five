# TLS Certificate Information (certinfo)

## What is it?

This utility can be used to display the details of a certificate with the exception of the public key and signature data. These can be extracted from the full certificate downloaded in pem format using the certdump utility. The certinfo is designed to work with certdump. Once the certificate has been downloaded with certdump, it can be viewed with certinfo without the need to download it again.


## Install Using Homebrew

```
brew tap ericem/two-pow-five
brew install certinfo
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

### Run Time Requirements

In addition to the build requirements, install the run time requirements.


```
brew install openssl
```

## Usage


Display certificate:
```
certinfo <certficate>
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

```
certinfo www.example.com
```

```
certinfo www.example.com.cert.pem
```
