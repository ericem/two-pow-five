# Knife Node Search Cache

## What is it?

If you have ever used the Chef Knife utility to search for a group of nodes,
you know that queries can be slow at times. This utility will transparently
cache the results of a Knife search, greatly speeding up your automation
when you want to do something with those results.

## Install Requirements

```
brew install crystal
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


## Usage

The syntax for 'nodes' is extremely simple. It only supports a single type of Knife node index query based on the logical AND of two 'tags' fields.

Syntax:

```
nodes <tag1> <tag2>
```

Which translates to:

```
knife search node 'tags:<tag1> AND tags:<tag2>' -F json -a ipaddress
```

"Does it support more keys than the 'tags' key?" No! If I wanted more options I would use Knife! 😛 "Well, then what is it good for?" Lots of things if your infrastructure is setup with the UNIX philosphy in mind. Here are some examples.

### Examples

Find all webservers in the staging environment:
```
nodes staging webserver
```

Expected Output:

```
www1.example.com
www2.example.com
www2.example.com
```

Use Dig to resolve the hostname of the nodes and save the IPs to a file:

```
nodes staging webserver | xargs dig {} +short | tee webservers.txt

```

Expected Output

```
192.168.168.1
192.168.168.2
192.168.168.3
```

Ping all the webservers to see if they are up:

```
nodes staging webserver | fping
```

Expected Output

```
www1.example.com is alive
www2.example.com is alive
www3.example.com is alive
```

Create a handy alias:

```
alias webservers-up='nodes staging webserver | fping'
```

Now when you want a a quick check of your webservers:

```
webservers-up
```

Note: If you don't have fping installed, you can get it from Homebrew. It's a wicked fast version of ping, designed for automation.

```
brew install fping
```

Use curl to check the webserver service is available:

```
nodes staging webserver | xargs -n 1 -I {} sh -c "curl -Ls -o /dev/null --connect-timeout 1 {} &>/dev/null && echo '{} available' || echo '{} down'"
```
Expected Output

```
www1.example.com available
www1.example.com down
www1.example.com available
```

Put a function in your $HOME/.bashrc:

```
webservers-health() {
  red='\e[0;31m'
  green='\e[0;32m'
  normal='\033[0m'
  nodes staging webserver | xargs -n 1 -I {} sh -c "curl -Ls -o /dev/null --connect-timeout 1 {} &>/dev/null && echo \"{} ${green}available${normal}\" || echo \"{} ${red}down${normal}\""
}

```

## Force a Cache Refresh

By default nodes will cache the results for 1 hour. If you want to force nodes to refresh the data, use the 'REFRESH' environment variable:

```
REFRESH=true nodes staging webserver
```

## Delete the Cache

All of the cache files are stored in the following locaion:

```
$HOME/.cache/nodes/<tag1>/<tag2>.txt
```

Just delete the files or directories to clean things up when you are done.
