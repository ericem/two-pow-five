# Process Health Monitor (healthmon)

## What is it?

This is a very simple process monitor that can be used as a remote health-check service. When healthmon starts it begins listening on all interfaces (port 3000). An HTTP Get request to the the root path will return a listing of all the running processes on the system. An HTTP Get request with a process ID in the URL will return a json formatted health message for the process. The message includes the CPU, and memory utilization for the process as well as the total uptime for the process. If a request for a dead or unknown process ID is received, healthmon will return a 404 message, also in json format. The healthmon server supports basic authentication and TLS. 

## Install Using Homebrew

```
brew tap ericem/two-pow-five
brew install healthmon
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


Start healthmon:

```
healthmon
```

Expected output:

```
[development] Kemal is ready to lead at http://0.0.0.0:3000
```

Change the default listening port: 
```
healthmon --port 8080
```

Change the default listening interface:
```
healthmon --bind 192.168.99.99
```

To enable TLS:
```
healthmon --ssl --ssl-key-file FILE --ssl-cert-file FILE
```

To enable basic authentication set the environment variable AUTH=true. This will set the username to healthmon and a random password will be generated. Check the log output to see the generated password.


Enable Basic Authentication:
```
AUTH=true healthmon
```

Expected Output:
```
[development] Enabling basic authentication
[development] Username is healthmon
[development] Password is TBF7DknDgvQa_Q
[development] Kemal is ready to lead at http://0.0.0.0:3000
```

Instead of using the randomly generated password, you can specify a password by setting the AUTH environment variable to any value except true.

```
AUTH='ding-dong-the-process-is-dead' healthmon
```

## API

Get all process ids:

Request:
```
GET /
```

Response:
```
{"pids" ["2 bash", "4 sleep" ... ]}
```

Get a process id health status:

Request:

```
GET /PID
```

Response:
```
{"uptime":"5d 7h 52m 40s","cpu_pct":0.0,"mem_pct":0.0,"mem_kbytes":8.0}
```
