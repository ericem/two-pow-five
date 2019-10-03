# Certificate Generator (certgen)

## What is it?

This is a companion utility to the other cert utilities that I have created. This one is a very, very, simple CA certificate and host certificate generator. It doesn't offer any options except for the password for the CA private key. It first creates a self-signed CA certificate, if none is detected, and then it creates the host certificate, suitable for use as a web server. The certificates use elliptic curve cryptography for the public key algorithm, and sha256 for the message digest, making them smaller and faster than an equivalent RSA key. If there is no CA password set, a random one will be generated for encrypting the private key using the aes256 cipher.


## Install Using Homebrew

```
brew tap ericem/two-pow-five
brew install certgen
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
brew install <requirement>
```

## Usage


Create a CA and host certificate:

```
certgen HOSTNAME
```

Expected Output:
```
Generated CA key with passphrase 2Tdj3jEhfuSdew
```

Set a password for the CA private key a create the certificates:

```
PASS=rootme certgen HOSTNAME
```

There is not output when a password is specified for the CA private key.


Set the Country, Organization, and Canonical Name for the CA Certificate:
```
C=US O='My Certs' CN='My Root CA' certgen HOSTNAME
```

### Examples

Create a CA for a web server in the 'test' domain:
```
certgen www.test
```

Output:
```
Generated CA key with passphrase 77U6V7guFs5RJA
```

Note: The 'test' domain is specified in (RFC 6761)[https://tools.ietf.org/html/rfc6761] for use in testing. It must behave like any other domain according to resolvers, which it makes a good candidate to use for self-signed CA certificates and local development tasks.

Create another host certificate in the 'test' domain for a file server:
```
PASS=77U6V7guFs5RJA certgen files.test
```

This time, only the host certificate will be created using the CA certificate from the previous run. Also note that in this run, you must supply the password for the CA certificate private key generated in the first run.

### Adding the CA Root Certificate to the Trust Store

To prevent the browser (or curl from the command line) from warning about self-signed/untrusted certificates, use the Keychain Access app to add the CA certificate generated using certgen to the login keychain. Once added, additional host certs created by certgen will be recognized without problems.

### Using the Host/CA Certificate Chain

After running certgen, three files will be create for each host 1) a certificate (host.domain.cert.pem), 2) a private key (host.domain.key.pem), and 3) a certificate chain (host.domain.chain.pem). Most webservers require just the private key and certificate chain for their configuration. The chain file is merely the host cert and ca cert concatenated together in one file with the CA cert the last cert in the file. Some webservers or certificate using software may require a different order for the certs, in which case you will have to generate the chain file yourself.
