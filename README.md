# Cerner 2^5 Programming Competition

This repository contains my entries for the 2019 edition of the Cerner 2^5 programming competition. This is my first year to participate in 2^5 (I am a new associate at Cerner), and it is my hope that my entries embody engineering productivity by creating entries that solve real problems faced in my job this past month and by creating entries that can make my job simpler and more efficient in the future. Of course, there are a few entries thrown in just for fun!

## The Rules

> In celebration of Programmer's Day, Cerner is holding a programming competition
for the sixth year in a row. For 32 days (September 13-October 14th), we will
be accepting code submissions (in any language) that represent the concept of
engineering productivity.


* Any Cerner associate can participate.
* Submissions must be on a public repository on github.com.
* Only 1 submission per day will count.
* Submissions must be 32 lines of code or less.  (Lines will be counted based on the terminal symbols for the language, not based on a number of characters per line.) Comments will not count as lines.
* Include a comment in your code of "cerner_2^5_2019".
* The code must be syntactically correct.

## The Disclaimer

It should be pretty obvious, but unless it is not clear, let me state it in plain terms: **NONE OF THIS IS PRODUCTION QUALITY CODE**. These entries, while fully functional and packed with features, have little defensive code. Everything is happy path, with little or no error checking. What do you expect in 32 lines?? 

## The Entries

I work on a 'big data' operations team, therefore I have focused my entries for the 2^5 competition on applications and utilities that increase the productivity of a system engineer working in a similar environment. For most entries, I used a language called Crystal which I have been wanting to learn for awhile. It is similar to Ruby (which I am learning for work), so I thought it would help me to continue honing those skills. However, as it turns out, Crystal stands on its own merits as a fantastic language for devops development and has become my secret weapon for building compact, yet functional apps in a mere 32 lines of code. The tag line for Crystal is "Slick as Ruby, Fast as C." It has the same terse, easy to read syntax as Ruby, but is statically type checked and compiles to a single native binary for easy deployment. All great qualities for quickly building tools to improve engineering productivity.


### 1. Stack Overflow Trace (sotrace)

As I am new to Ruby, coming to the devops space from a background in Python, I find I spend a considerable amount of time on StackOverflow searching for answers to my Ruby problems. The 'sotrace' application, helps reduce the debugging time of Ruby code by trapping errors and looking them up on StackOverflow. Presenting you with links to the top 10 answers to the error that you have received.

### 2. Parallel SSH Command (psshcmd)

We use Chef extensively for configuration management and often need to run chef-client across a group of nodes. There is the *knife ssh* command, but knife queries can be really slow, and if you need to run several commands can become frustrating. I wanted something simpler and faster. The *psshcmd* utility is built on top of the libssh2 C library, so it is fast and light-weight. It is not designed for interactive use, instead it only runs a command and then captures the exit status, making it really easy to integrate into automation scripts.

### 3. One, Final, Last, Check, Test Runner (lastcheck)

We follow a *config as code* philosophy on my team which means lots of PRs and lots of continuous integration tests. Often the CI tests can take 20 to 30 minutes to run across multiple platforms, and it can be frustrating to learn 15 minutes in that one of your commits fails a simple lint or style check. Obviously you should run tests locally before a push, but sometimes you make a seemingly simple change and forget to re-run the checks. The *lastcheck* utility is a git pre-commit hook that can be installed into your repository that will run your default rake task (usually tests) and send you a Microsoft Flow notification when the tests are complete. Don't underestimate the cool factor of getting a notification on your Apple Watch when your tests are complete!

### 4. System Stats Broadcaster (statscast)

The *statscast* utility is a simple utility that broadcasts summarized process and CPU utilization statistics over a multi-cast UDP channel.  What good would this be versus running *top* inside an ssh session? Well, what if you want to monitor CPU utilization across 100 servers in an ad-hoc fashion? That's where statscast can shine. Set statscast to run on your servers, and then start up a *statsrecvr* (see entry 5) instance on your management workstation. The combination of statscast and statsrecvr make analyzing CPU utilization outliers much more productive.

### 5. System Stats Receiver (statsrecvr)

The *statsrecvr* utility listens on a multi-cast UDP channel for a *statscast* broadcast message and then  outputs the result to stdout. Each output line contains the IP address of the statscast sender, making it easy to use traditional Unix utilities like awk, sed, grep, and tee to parse, filter, and log the output. To me engineering productivity IS the Unix philosophy, small utilities working together to solve big problems.

### 6. Knife Node Search Cache (nodes)

For this entry, I built the *nodes* utility as the direct result of the severe pain I felt when running a *knife node search* command against a Chef server containing a large number of nodes. Often times these searches would take upwards of 30 to 40 seconds, EACH TIME I RAN IT. Imagine doing this many times a day. The *nodes* command can be run instead of a *knife node search* and it will transparently cache the results into a local cache. The next time the nodes command is run, the results of the search will be re-played from the cache, returning in a few *ms* instead of the 30 to 40 seconds in the initial search. The nodes command like the statscast/statsrecvr commands is designed to fit in nicely with other Unix tools, and its output can be piped into other utilities like ping for testing node connectivity or dig for looking up a hostname.

### 7. SSH Jump Box (jumpbox)

I built this utility, *jumpbox*, as a challenge to see if I could build a more secure, and yet more flexible bastion host solution than what is typically used in an operations environment. I have worked with some pretty terrible bastion solutions over my career, the worst being those that only allow Windows Remote Desktop access to a Putty client. No copy paste from your local workstation, no possibility for automation, sapping productivity in the process. The *jumpbox* utility is launched by the ssh daemon when a connection has been authenticated, it executes a Docker environment connecting the logged in user to the container. This allows users to jump into an environment specifically configured for their task. Need to add a utility for a user or patch a vulnerability, simply update the Docker container and re-connect. With jumpbox, users do not have shell access to the ssh host, providing enhanced security, but can also have a feature rich environment provided by the Docker container. A Win-win for engineering productivity.

### 8. SSH Jump Box Authentication Server (jumpauth)

The *jumpauth* utility provides an authentication service for the ssh daemon. Instead of using local user accounts to authenticate users, which can be problematic on large operations teams, jumpauth can be used instead. It uses public-key authentication for securely authenticating users, but in a more scaleable and manageable manner than shipping keys from server to server. With jumpauth, the accounts and keys are stored in a Redis database for fast, scaleable querying, but could be easily extended to work with keys stored in an LDAP database as well.

### 9. Linux Kernel Logging to Web Console (webcon)

I built *webcon* to solve the problem of debugging Linux boot and driver problems when working in cloud environments that do not provide remote console access. Webcon works with a little known (obscure?) feature of the Linux kernel that allows boot messages to be sent over a network socket. Webcon, provides a receiver for these debug messages, but then re-broadcasts them over a web-socket. So, yes, you can have kernel debug messages, in the browser, served in-real time, IN COLOR! Webcon makes debugging sessions much more productive and reduces the time to solve boot problems.

### 10. Track a Streak of Anything (streak)

I built *streak* while about 1/3 of my way into the 2^5 competition as a way to track my progress and to provide daily motivation to keep going. Maybe some people prepared their entries in advance, but I didn't learn about the competition until right before the start, and so I have been building the entries one-by-one in the evening, after work, and after my family responsibilities are done for the day. I needed some motivation to keep going, and I've learned from experience as a long-distance runner that maintaining a streak is easier if you have a visual tool for checking off the days. What I need was a command-line tool to track my streak, thus *streak* was born. When run, streak displays a monthly calendar in the terminal with the days that you have marked as complete, high-lighted in green. It reads completed entries from a log file, which can be updated by any Unix utility you wish. For instance, I have a git *pre-push* hook that updates the log file each time I push to this repository, so I've been tracking my progress in a completely automated fashion. Any time I need motivation, I just run *streak* to see that beautiful calendar of un-interrupted daily pushes.

### 11. Time Left for Getting Things Done (timeleft)

I built *timeleft* after reading an article on Hacker News about a personal journaling technique where the author recorded (among other things) the number of days since their birth. I thought, well that's interesting, but if you need motivation to make the most of every day, you are tracking the wrong metric. You should be tracking how much time left you have left. So, I built *timeleft*, which queries a life expectancy database prepared by the National Center for Health Statistics, a division of the Center for Disease Control (CDC). Using your birthday and your predicted life expectancy, timeleft will calculate how many days you have left and on what day you can be expected to pass. Put timeleft in your .bashrc and when you see the days ticking down, just see how much more you get done each day!

### 12. A Secret Store using MacOS Keychain (secret)

Everyone on my team uses a MacBook as their daily driver, so most of the entries I have submitted for 2^5 were designed and tested on macOS, but can actually be compiled to run on Linux too. This entry is macOS specific but solves a common problem we have on our team. How can we secure the numerous passwords we have to use for the various environments that we support, but also improve engineering productivity?  Some people use LastPass, Bitwarden, or 1Password, but I wanted a utility that was native to macOS yet could be integrated easily into other command line utilities. With secret, you can add passwords from the command line, but they are stored in the macOS Keychain, so when you logout or lock your workstation they are locked as well. When you are already logged in and your keychain is unlocked you won't be repeatedly prompted for your keychain password saving time when moving between numerous systems.  Secret provides a shortcut to copy a password to the clipboard so it can be pasted into an ssh session or web page, or even can scripted with expect. Secret means you can use long, secure, random passwords, but with less typing and therefore more work getting done.

### 13. Battery Status for the Terminal (battstat)

I spend most of my day with a full-screen terminal, which means when I am away from desk (and my charger), I don't notice when my battery is nearly dead and have come close a few times from having my machine shutdown. The *battstat* utility attempts to solve this problem, but providing a battery level indicator for the command line. Like my other utilities that follow the Unix philosophy, it does one thing only, outputs the current battery level with a nice little unicode icon showing the current battery status in a visual way. The battstat utility can be integrated into other scripts easily. In my case, I call it from my [tmux statusbar](https://leanpub.com/the-tao-of-tmux/read#status-bar), so that I always see the current battery level even when I'm in a full-screen terminal. The battstat utility, as well as the secret utility, were written in a language called [Nim](https://nim-lang.org). I originally planned to write my entries in several different languages, but I learned quickly after using Nim, that my original choice of Crystal was much better suited for packing more features into less lines.

### 14. TMUX Pane Stats (panestats)

As I've already stated, I spend most of my day in a terminal, and most of that is done working on a git repository. The *pantestats* utility adds a heads-up-display to the bottom border of my terminal. When using tmux, you can divide your terminal window into multiple [panes](https://leanpub.com/the-tao-of-tmux/read#panes) each with their own shell and a border surrounding it. With panestats turned on, the bottom border also displays the commit status of the current git repository, the current Chef environment and the current Ruby version. All necessary to provide situational awareness when moving around a large devops code base, making for a much more productive engineering experience.

### 15. URL Status Monitor (urlstatus)

I built *urlstatus* out of frustration of dealing with failing CI/CD pipelines, because the builds depended on another system that was experiencing intermittent failures. With urlstatus, I could monitor the URL endpoint of the problem system, and see over time how latency and connectivity were being impacted. This helped isolate problems with our CI pipelines versus problems with the external system and reduced wasted debugging time when it was a problem with the external system.  In an *ideal* world where every dependent service is instrumented and monitored, urlstatus would not be necessary, but in the *real* world where engineers don't have control over the services they consume, urlstatus can be very useful.

### 16. Certificate Dumper (certdump)

I built the the series of certificate related utilities after having a need to create a certificate authority and some node certificates. Anyone working with Openssl and its suite of utilities will know how frustrating it can be to use with its conflicting and often times obtuse parameters. Ideally these utilities would be sub-commands of a larger utility, but I had a need wanted to fit the into the 32 line limit of this competition. The *certdump* utility can be used to download a certificate from a server. For instance, say you wanted to see what X.509 extensions Google uses for the certificate at google.com. You can use certdump to connect to google.com and export the certificate in pem format which can then be examined with certinfo, described below. You can also download the associated certificate authority (CA) and certificate chain associated with a server.

### 17. Certificate Verifier (certverify)

The *certverify* utility can be used with certdump utility to verify that a certificate downloaded with certdump and it associated certificate chain is valid and signed by a particular certificate authority. Each cert utility follows the Unix philosophy and is orthogonal to the other utilities.  Certverify was the first entry in this repository that I created a [Homebrew](brew.sh) binary package (bottle) for. This makes sharing and installing the utilities in this repository really simple.

### 18. Certificate Information (certinfo)

The *certinfo* utility can be used to examine the details of a certificate that was previously downloaded with certdump. Since building this utility, I have used it many times already to debug issues with certificate creation where the X.509 extensions were improperly created and would not pass validation. 

### 19. Super Simple and Secure Static File Server (serveme)

The serveme utility is a static file web server that I built partly in jest while experiencing problems with a binary repository server. I thought surely I could build something in 32 lines that would be more reliable, what I built turned out to be really useful to have in an engineers daily toolkit.  The way serveme works: you cd into a directory that you want to serve files from and then run the *serveme* command. For most use cases, no configuration necessary. Surprisingly, serveme supports basic authentication and TLS encryption in a mere 30 lines, +1 for Crystal! What use cases would serveme help with? How about staging installation files in a lab environment onto a server, or sharing files at a conference in a cross-platform manner (not everyone has a MacBook with Airdrop).

### 20. Certificate Generator (certgen)

After building serveme, I realized I had a gap in my series of certificate utilities. What I needed to go along with serveme was a tool to generate self-signed certificates. The *certgen* utility makes it super simple to create a certificate authority and a certificate to use with serve. It doesn't require any options, except a hostname with domain, and creates certificates in a secure manner for the most common use, case of a local development web server.

### 21. Certificate Trust Store (certtrust)

After creating a certificate authority using certtrust, you must add it to your local certificate trust store, which is Keychain on macOS. Normally, this would require loading a web page in a browser and clicking through several prompts and scary browser warnings until you override the trust status for the certificate. The *certtrust* utility makes this a very simple command line operation. It also supports other operations on the trust store including listing and deleting the certificates from the store.

### 22. Internet Speed Test (speedtest)

Often times as an engineer you want to check the quality of your W-iFi or Internet connection, to rule out application or system problems. The *speedtest* utility is a simple command that doesn't require any options that returns the current network throughput in mega-bits per second. The utility with its cleanly formatted output can be easily integrated into other scripts. 

### 23. Network Interface Stats (ifstats)

The *ifstats* utility is a companion to the speedtest utility, although it can also be used in a stand-alone manner as well. When launched from the command line it runs in the background, displaying the current throughput metrics in the top right corner of the terminal. If you run a speedtest while ifstats is running in the background, you can see a heads-up display of the real-time throughput statistics including packets per second and mega-bits per second. 

### 24. Network Ping Test (pingtest)

After building speedtest and ifstats, I thought it would be useful to also measure network latency. The speedtest utility works by downloading a large file from a popular Internet speed testing site called *speedtest.net* and measuring the time to download the file. The *pingtest* utility works by pinging the speedtest.net site 5 times and then averaging the measured latency. In this way, one can get a sense of the congestion in the network between your device and the speedtest.net site. Both the speedtest and pingtest utilities support changing the host used for the tests if a closer server is available. 

### 25. Process Health Monitor (healthmon)

I built *healthmon* because sometimes you just want a simple way to monitor the health of a single process on a remote machine for a short amount time. Yes, you could use Zabbix, collectd or one of many other utilities, but sometimes as a  systems engineer you have an immediate need to monitor a process in an ad-hoc fashion. This is where healthmon comes in handy. The healthmon utility has an embedded web server providing a simple API to query the health status of a process including uptime, as well as cpu and memory utilization. 

### 26. Process Health Status (healthstatus)

When I first built healthmon I planned to just use curl to query the API for the status of a process. However, I quickly realized that by building a custom client, I could reduce the complexity of the utility add a few features that make it easier to fit into a Unix pipeline. The *healthstatus* utility connects to a healthmon instance and queries the API for the status of a process ID in a loop. This output stream can then be piped to other utilities for filtering, aggregation or plotting. Plotting? Yes, plotting, see my next utility that I built called pipeplot.

### 27. Pipe Some Data and Plot It (pipeplot)

I've used Gnuplot for many years, and It's my goto tool when I need to create a plot of time series data like network throughput numbers or memory utilization. I like Gnuplot because it can be scripted like any other Unix command line utility. One of my favorite tricks is to create a Makefile that can turn a directory full of csv files into PDFs that can then be embedded into report (also generated by make using Pandoc). One tool I have never seen until I created pipeplot is a tool for generating plots from a continuous stream of data instead of generating plots from data files. Pipeplot reads space delimited data piped to it over STDIN, and then periodically generates a PNG plot after a set interval has passed, by default 1 hour. Pipeplot works great with healthmon and healthstatus to gather and plot process related metrics like memory and CPU utilization. You could even use serveme to serve the PNG files over HTTP, creating a tiny ad-hoc monitoring system, engineering productivity at its finest.

### 28. Process Death Watch (deathwatch)

I created the *deathwatch* utility in response to an issue we were experiencing where an unknown process was sending a SIGQUIT signal to one of our services. Because the issue occurred infrequently we were unable to determine the root cause. Deathwatch uses a tool from the [BPF Compiler Collection](https://github.com/iovisor/bcc) (BCC), to do the heavy lifting. It compiles down to eBPF and runs in the Kernel to trap system signals in real-time. The deathwatch utility monitors for the signal events and then sends a Microsoft Flow notification when the process under scrutiny is killed. This makes it a cinch to find the proverbial needle in the haystack, when a rare event happens.

### 29. Hobo - Like Vagrant for Docker Containers (hobo)

The *hobo* utility is meant to be the Docker container parallel of the excellent [Vagrant](https://www.vagrantup.com) virtual machine utility from Hashicorp. Where Vagrant is used to make it easy to start up and work with VMs, hobo is designed to make it easy to start up and work with containers. The use case I was trying to solve for was making it easier to work on projects that required Linux. With hobo, you can put a Hobofile in the root of your project repository that describes the container's base image and command to run. Then when someone forks the repository, they merely need to run `hobo up && hobo login` to immediately be connected to a shell in container that has all the proper software installed for working on the repository. The hobo utility increases engineering productivity by getting other engineers up to speed on a project in a more repeatable and efficient fashion than installing development tools into a local environment. 

### 30.  Get Your IP Server (getipservr)

As an engineer working in different environments, it's sometimes hard to know the network topology and how firewalls may be translating your device's IP address. There are public services like whatsmyip.org that can tell you what the external IP address of your firewall is, but how can you trust the information it is giving you? The *getipservr* utility is meant to be an IP identification service like whatsmyip, but can be used on a private server, and has features to ensure the integrity and authenticity of the data it provides. 

### 31. Get Your IP Client (getip)

The *getip* utility is a client utility designed to work with a getipservr service. As I mentioned before, I could use curl to script interactions with getipservr, and in fact I did during development of getipservr. However, I wanted a client that would be simpler to integrate into other scripts and one that could automatically verify the integrity and authenticity of the data received from getipservr. The getip client uses TLs encryption along with authentication to ensure privacy and integrity of the data exchange. It also uses one-time-password tokens and the TOTP algorithm as an additional check on the authenticity of the data sent by the getipservr service. In a future project, I plan to build a dynamic DNS client that will build upon getipservr and getip client to update A records in the AWS Route53 DNS service.

### 32. Level Up Your Engineering Skills (levelup)

For my finally entry in 2^5 I wanted to reflect that to be a productive engineer you need to have a [growth mindset](https://hbr.org/2016/01/what-having-a-growth-mindset-actually-means) and be constantly learning to improve your skills. I knew right away that I wanted to build something with [spaced-repetition learning](https://en.wikipedia.org/wiki/Spaced_repetition). I have used spaced-repetition learning tools in the past (such as the excellent Anki application) and they have worked well to help me learn new topics. However, I wanted a tool that I could use from the terminal, and I wanted it integrated into my daily routine so that I could learn new topics in a completely seamless fashion. The *levelup* utility is a front-end to another excellent spaced-repetition learning application called [drill](https://github.com/rr-/drill). Levelup runs within your bash prompt, constantly checking if you have studied recently, and If you have not studied, it prompts you to begin a new study session. Short, simple, productive.

