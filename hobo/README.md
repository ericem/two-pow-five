# Hobo - Like Vagrant for Docker Containers (hobo)

## What is it?

If you've worked with lots of virtual machines for development and testing, then you are probably familiar with Vagrant, A tool for automating VM creation. Hobo brings the concept of Vagrant to Docker containers. You begin by creating a Hobofile in the root of your project that contains the details of the container. Then you can use simple commands like 'hobo up', and 'hobo login' to create and access your container. Hobo takes care to automatically bind mount your project directory to /hobo inside the container. Hobo makes it very simple to begin developing on a project by bundling project dependencies into a container that can be started quickly. The hobo project includes a Hobofile that can be used to build hobo itself:

```
hobo up
hobo login
cd /hobo
make
```


## Install Using Homebrew

```
brew tap ericem/two-pow-five
brew install hobo
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
brew cask install docker
```

## Usage

### Create a Hobofile

The Hobofile is a yaml file that describes how to start your container:

Hobofile:
```
image: alpine:latest
command: /bin/sh
```

It must contain the following attributes:

image   - The Docker container name and optional tag.
command - The command to start inside the container, should be shell for development

### Hobo Commands

Start hobo:

```
hobo COMMAND
```

Commands:
up      - start the container specified in the Hobofile
login   - attach to the containers stdin/stdout and enter a shell
status  - get the current status of the conatainer
destroy - kill any processes running in the container and remove the container

