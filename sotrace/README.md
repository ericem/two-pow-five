# StackOverflow Trace

## What is sotrace?

It is a small command line wrapper that will trap errors on stderr and then
look them up on StackOverflow. If it finds a matching question on
StackOverflow, it will print out the top 10 matching results with links to the
answer. Currently, sotrace only works with Ruby programs and has partial
support for Python programs.


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

## Testing

To run the included tests:

```
make test
```

## Usage

For now, you must specify the language of the program to trace along with the
program and it's arguments:

```
sotrace <language> <command> <arguments>
```


## Example

Here is an example for running one of the included tests, which is a Ruby program:

```
sotrace ruby tests/ruby-error-filenotfound.rb
```

Here is the expected output:


```
./sotrace ruby tests/ruby-error-filenotfound.rb
tests/ruby-error-filenotfound.rb:4:in `initialize': No such file or directory @ rb_sysopen - this-file-should-not-exist-orlly??.txt (Errno::ENOENT)
        from tests/ruby-error-filenotfound.rb:4:in `open'
        from tests/ruby-error-filenotfound.rb:4:in `<main>'

Looking up Error on Stackoverflow...

How do I solve: "Errno::ENOENT - No such file or directory @ rb_sysopen - "?
  https://stackoverflow.com/questions/56871348/how-do-i-solve-errnoenoent-no-such-file-or-directory-rb-sysopen

Errno::ENOENT - No such file or directory - env -u GIT_CONFIG git -C "[...]/.cocoapods/repos/master" config --get remote.origin.url (Windows 10)
  https://stackoverflow.com/questions/54204169/errnoenoent-no-such-file-or-directory-env-u-git-config-git-c-coc

Files in public directory in Rails - Errno::ENOENT (No such file or directory @ rb_sysopen
  https://stackoverflow.com/questions/51505122/files-in-public-directory-in-rails-errnoenoent-no-such-file-or-directory

Getting Errno::ENOENT during Dir.foreach block when I know file exists?
  https://stackoverflow.com/questions/19991442/getting-errnoenoent-during-dir-foreach-block-when-i-know-file-exists

Could not detect rake tasks - Errno::ENOENT: No such file or directory - R
  https://stackoverflow.com/questions/54721269/could-not-detect-rake-tasks-errnoenoent-no-such-file-or-directory-r

Sass: errno::enoent: No such file or directory
  https://stackoverflow.com/questions/29499691/sass-errnoenoent-no-such-file-or-directory

chef template gives No such file or directory @ rb_sysopen Errno::ENOENT
  https://stackoverflow.com/questions/54576803/chef-template-gives-no-such-file-or-directory-rb-sysopen-errnoenoent

Errno::ENOENT No such file or directory @ rb_sysopen sinatra wont load views
  https://stackoverflow.com/questions/53510818/errnoenoent-no-such-file-or-directory-rb-sysopen-sinatra-wont-load-views

No such file or directory @ rb_sysopen - site/tmp/pids/puma.pid (Errno::ENOENT)
  https://stackoverflow.com/questions/53072995/no-such-file-or-directory-rb-sysopen-site-tmp-pids-puma-pid-errnoenoent

Errno::ENOENT: No such file or directory @ rb_sysopen
  https://stackoverflow.com/questions/51560773/errnoenoent-no-such-file-or-directory-rb-sysopen

```







