# Certificate Trus (certtrust)

## What is it?

This is a utility for adding and delete CA certificates from the macOS certificate trust store which is the login Keychain by default. Once a CA certificate has been added to the store and marked as trusted it can be used to verify other certificates signed by the CA. The certtrust utility is designed to work with the certgen utility, to make it very easy to create a self-signed CA certificate, and then import it into the macOS Keychain. 


## Install Using Homebrew

```
brew tap ericem/two-pow-five
brew install certtrust
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

## Usage


Add a certificate:

```
certtrust add CERTIFICATE
```

To delete a certificate specify the name of the certificate as listed in the `certtrust list` command. The name field must uniquely identify the certificate.

Delete a certificate:
```
certtrust del NAME
```

List certificates:
```
certtrust list
```

To use a Keychain other than the default login Keychain, set the environment variable KEYCHAIN.

Set a different Keychain:

```
KEYCHAIN=<keychain-name> certtrust add CERTIFICATE
```

### Examples

Add a certificate:
```
certtrust example.com.cert.pem
```

List certificates:

```
certtrust list
```

Expected Output:
```
*.cerner.com
windows.vagrant.local
Certgen Root CA (example.com)
```

Delete certificate:
```
certtrust del example.com
```
