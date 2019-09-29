#!/usr/bin/env bash

# Generate a new project from a skel directory

TYPE=$1
NAME=$2

usage() {
  cat << EOF
Usage: $(basename $0) <PROJECT_TYPE> <PROJECT_NAME>

Supported types:
  crystal
EOF

}


if [ -z "$TYPE" ] || [ -z "$NAME" ]; then
  usage
  exit 1
fi

if [ -d $NAME ]; then
  echo "A project with that name already exists."
  exit 1
fi

if [ ! -d skel/$TYPE ]; then
  echo "That project type does not exist."
  exit 1
fi

cp -r skel/$TYPE $NAME

cd $NAME

find . -type f -print0 | xargs -0 sed -i '' s/%APP%/$NAME/g

case $TYPE in
  crystal)
    mv app.cr $NAME.cr
    ;;
esac

