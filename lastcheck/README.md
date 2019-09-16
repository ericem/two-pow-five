# One Final Last Check pre-commit Hook

## What is it?

How many times have you run your tests, they passed, and then you make a tiny
change but you forget to run tests again before you push it up for a PR? Next thing you
know, the automated tests have kicked off and have FAILED! How embarrasing,
well this should hopefully fix that. This is a pre-commit hook that will run a
projects test suite, one last time, before the commit happens. If the tests pass,
the commit will be made and a push notification will be sent using Microsoft
Flow to your device of choice.


## Install Requirements

For this script, all that is required is bash and curl. To install simply copy
pre-commit to .git/hooks:

```
cp pre-commit .git/hooks
```
To get notifications from the script you will need to create a Microsoft Flow
HTTP endpoint. The instructions are below.


## Usage

The lastcheck pre-commit check is only designed to work with Ruby projects. It
will parse the files that are about to be committed and if a Ruby file has
changed it will check for a Rakefile and launch rake. Once the tests are
complete, it will send a notification message using the Microsoft Flow API.


## Creating a Microsoft Flow API Endpoint

1. Install the Microsoft Flow App on your device
2. Go to flow.microsoft.com
3. Select "My flows" from the menu on the left
4. Select "+ New" from the top menu
5. Select "+ Instant-from blank"
6. Fill in lastcheck for the Flow Name
7. Select "When an HTTP Request is Received" from the list of triggers
8. Select "+ New Step"
9. Select Notifications Icon
10. Select "Send me a mobile notification" for the action
11. Fill in a useful message for the Text field: "Ding tests are done!"
12. Click Save
13. Expand the "When a HTTP request is received" trigger and locate the HTTP POST URL
14. Copy the HTTP POST URL to the clipboard
15. Edit your $HOME/.bashrc to add a LASTCHECK_URL variable:

```
export LASTCHECK_URL=<HTTP POST URL>
```

