# URL Status Checker (urlstatus)

## What is it?

This is a utility to continuously monitor an HTTP endpoint. It uses curl in the background to connect to a URL and gather some performance metrics, then reports the statistics and any errors on the terminal. The terminal output is color coded to make recognizing issues during troubleshooting quick and easy.

## Install Build Requirements

Install the compiler:

```
brew install crystal
```

## Compiling

To build a debug version:

```
make
```

To build a release version:

```
make release
```

To install the binary:
```
make install
```

## Install Run Time Requirements

This utility uses curl for the http connection testing. If you build and run urlstatus on a Mac, curl is already installed by default. If you are building for another platform install curl using your package manager. You can also update curl to the latest version using Homebrew.

Update curl using Homebrew:

```
brew install curl
```

## Usage


Start the urlstatus monitor:
```
urlstatus <URL>
```

Output Fields:

```
TIMESTAMP CURL_EXIT_CODE STATUS_MSG HTTP_CODE TIME_NAMELOOKUP TIME_CONNECT TIME_APPCONNECT TIME_TOTAL
```

TIMESTAMP - RFC 3339 formatted timestamp when request is made
CURL_EXIT_CODE - The exit code of the curl process `man curl` for a complete listing of possible values
STATUS_MSG - Basic status of the request (success|error|fail). The value 'success' indicates that an HTTP connection was made and the server returned an HTTP code that was either a 1XX, 2XX, or 3XX. The value 'error' indicates that an HTTP connection was made but the server returned an error code either 4XX or 5XX. The value 'fail' indicates that the connection failed. Check the curl exit code for more details.

Example Output:
```
2019-09-28T01:26:44.581059000Z 0 success 200 0.032277 0.066425 0.0 0.102051
2019-09-28T01:26:45.704308000Z 0 success 200 0.005154 0.04245 0.0 0.080738
2019-09-28T01:33:31.828054000Z 6 fail 0 0.0 0.0 0.0 4.7e-5
2019-09-28T01:33:32.851235000Z 6 fail 0 0.0 0.0 0.0 3.9e-5
2019-09-28T01:33:52.530060000Z 0 error 400 0.030514 0.0 0.0 0.192225
2019-09-28T01:33:53.737765000Z 0 error 400 0.005457 0.0 0.0 0.081545
```

### Debug Output

If you encounter a connection failure you can enable DEBUG mode to print the curl command that was used in the request as well as the curl error messages. You can use the curl command string to retry the command manually, if needed.


Enable Debug Mode:
```
DEBUG=true urlstatus <URL>
```

Example Debug Output:

```
curl --write-out '%{time_namelookup} %{time_connect} %{time_appconnect} %{time_total} %{http_code}\n' --output /dev/null --show-error --head http.test
2019-09-28T01:39:54.269977000Z 6 fail 0 0.0 0.0 0.0 3.8e-5
2019-09-28T01:39:54.269977000Z 6 #curl: (6) Could not resolve host: http.test
```

### Sleep Interval

The default sleep interval is 60 seconds. You can change the sleep interval between requests by setting the SLEEP environment variable.

```
SLEEP=1 urlstatus <URL>
```
### Connection Timeout

The default connection timeout is 10 seconds. You can change the connection timeout by setting the TIMEOUT environment variable.

```
TIMEOUT=60 urlstatus <URL>
```

### Examples

I like to use the handy HTTP testing site (httpbin.org)[http://httpbin.org] when I need to make some sample requests.

Checking a 200 ok:
```
urlstatus httpbin.org/status/200
```

Checking a 302 redirect:

```
urlstatus httpbin.org/absolute-redirect/1
```

Checking a 404 error:
```
urlstatus httpbin.org/status/404
```

Checking a 500 error:
```
urlstatus httpbin.org/status/500
```

Checking a DNS error:

```
urlstatus http.test
```

Checking a slow response:

```
urlstatus httpbin.org/delay/10
```
