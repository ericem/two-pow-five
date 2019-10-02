# Super Simple Static File Server (serveme)

## What is it?

This is the simplest possible static file server. When serveme starts it begins listening on all interfaces (port 3000), and serves files from the current directory were the serveme command was run, no configuration required. An HTTP Get request to the the root path will return a listing of the files in the current directory. An HTTP Get request with a file name in the URL will return the file if found. The serveme server supports basic authentication and TLS. To simplify sharing files, when serveme starts it copies a curl command with the IP address, port and authentication credentials to the clipboard for easy pasting into a chat session.

## Install Using Homebrew

```
brew tap ericem/two-pow-five
brew install serveme
```

## Install From Source

### Install Build Requirements

Install the compiler:

```
brew install crystal
```

Install crystal library dependencies:

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
brew install <requirement>
```

## Usage


Start serveme:

```
serveme
```

Expected output:

```
[development] curl command copied to clipboard
[development] Kemal is ready to lead at http://0.0.0.0:3000
```

Change the default listening port: 
```
serveme --port 8080
```

Change the default listening interface:
```
serveme --bind 192.168.99.99
```

To enable TLS:
```
serveme --ssl --ssl-key-file FILE --ssl-cert-file FILE
```

To enable basic authentication set the environment variable AUTH=true. This will set the username to serveme and a random password will be generated. Check the log output to see the generated password. Note, the password will also be copied to the clipboard as art of the curl command that can be used to access the serveme instance.

Enable Basic Authentication:
```
AUTH=true serveme
```

Expected Output:
```
[development] Enabling basic authentication
[development] Username is serveme
[development] Password is TBF7DknDgvQa_Q
[development] curl command copied to clipboard
[development] Kemal is ready to lead at http://0.0.0.0:3000
```

Instead of using the randomly generated password, you can specify a password by setting the AUTH environment variable to any value except true.

```
AUTH='Ring-ding-ding-ding-dingeringeding!' serveme
```

When the serveme command starts up, it will copy a curl command to the clipboard for easy sharing. The IP address will be set to the primary network interface.

Example curl command:
```
curl -u serveme:Ring-ding-ding-ding-dingeringeding! http://192.168.99.99:3000/
```
