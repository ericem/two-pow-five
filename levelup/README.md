# Level Up Your Engineering Skills (levelup)

## What is it?

The levelup utility is an interface to the spaced-repitition learning utility called [drill](https://github.com/rr-/drill). Spaced repetition is a learning technique where newly learned concepts are shown at a more frequent interval while older and already understood concepts are shown less often. Using drill, concepts are learned by creating 'decks' of flash cards and then studying the decks on regular intervals. The Levelup utility is designed to run from your bash prompt, and if you have not studied your decks in set interval, it will prompt you to start a study session.


## Install Using Homebrew

```
brew tap ericem/two-pow-five
brew install levelup
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

Install the drill application:

```
pip3 install drillsrs
```

## Usage

Levelup is not designed to be run directly, instead it should be run from your .bashrc as part of a PROMPT_COMMAND. In this way, as you go about your work day, levelup can check if you have studied recently and prompt you to study if it has been awhile. So, to turn on levelup, you need to add it to your PROMPT_COMMAND through your .bashrc file.

Add levelup to your .bashrc.

$HOME/.bashrc:
```
PROMPT_COMMAND=levelup_prompt

levelup_prompt() {
  levelup
}
```

Levelup will store it's configuration data in $HOME/.config/leveup.yml. If for some reason you are having problems with levelup, you can delete this file, and it will be re-created automatically on the next run.


### Examples

Create a new deck:

```
drill-srs create-deck chef
```

Add a card to the deck:

```
drill-srs create-card -q "What is the command to converge a node?" -a "chef-client" chef
```

Study:

```
drill-srs study chef
```

