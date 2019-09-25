# Secret Store using macOS Keychain

## What is it?

If you work with many systems, it can be frustrating (and time consuming!) to constantly be typing passwords. This utility eases that burden in a secure manner. It is like most password managers with a few features that are better designed for a systems engineer: 1) a simple command line interface with orthogonal commands, 2) uses Keychain for key storage, so it can be locked when the machine is locked, 3) copies passwords to the clipboard for easy pasting into the terminal. 

## Install Build Requirements

This application is written in Nim, a different language than the previous entries. Make sure to install the compiler.

Install the compiler:

```
brew install nim
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

## Usage

### Creating a New Secret Store

Create a new keychain:
```
export KEYCHAIN="secrets.keychain"
security create-keychain -P $KEYCHAIN
```

Note: The keychain "secrets.keychain" is the default built into secret. If you want to change the default, set the environment variable "SECRETS_KEYCHAIN" with name of the secrets keychain. Make sure to add '.keychain' to the end. This will allow you to open the keychain using the Keychain Access application.

For example:
```
SECRETS_KEYCHAIN=supersecrets.keychain
```

### Key Manipulation Commands

Set a new secret:
```
secret set <keyname>
```

For example:
```
secret set staging
```

Will prompt for a password:
```
Password:
Retype password:
```

List all secrets:
```
secret list
```

Expected output:
```
staging
```

Copy a secret to the clipboard:

```
secret copy staging
```

### Where is the delete?

There are not enough lines to implement a delete, but here is the command to do it manually:

```
export SECRETS_KEYCHAIN=secrets.keychain
security delete-generic-password -a $USER -s <secret_name> $SECRETS_KEYCHAIN
```

Keep an eye out for the next version!

### Bash Completion

If you use Bash, here is a completion script that makes secret even more handy. It provides tab completion for all of the commands. Put it wherever your completion scripts are stored.

$HOME/.bash_completion.d/secret:
```
# Check for bash
[ -z "$BASH_VERSION" ] && return

_secret() {
    local cur prev
    cur=${COMP_WORDS[COMP_CWORD]}
    prev=${COMP_WORDS[COMP_CWORD-1]}

    case ${COMP_CWORD} in
        1)
            COMPREPLY=($(compgen -W "set copy list" -- ${cur}))
            ;;
        2)
            case ${prev} in
              set)
                COMPREPLY=( $(compgen -W "$(secret list)" -- ${cur}) )
                ;;
              copy)
                COMPREPLY=( $(compgen -W "$(secret list)" -- ${cur}) )
                ;;
            esac
            ;;
        *)
            COMPREPLY=()
            ;;
    esac
}

complete -F _secret secret
```
