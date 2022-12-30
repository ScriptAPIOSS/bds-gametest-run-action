#!/bin/bash

RE='[^0-9]*\([0-9]*\)[.]\([0-9]*\)[.]\([0-9]*\)\([0-9A-Za-z-]*\)'

step="$1"
if [ -z "$1" ]
then
  step=patch
fi

base="$2"
if [ -z "$2" ]
then
  base=$(git describe --abbrev=0 --tags 2>/dev/null| tail -n 1)
  if [ -z "$base" ]
  then
    base=0.0.0
  fi
fi

MAJOR=`echo $base | sed -e "s#$RE#\1#"`
MINOR=`echo $base | sed -e "s#$RE#\2#"`
PATCH=`echo $base | sed -e "s#$RE#\3#"`

case "$step" in
  major)
    let MAJOR+=1
    let MINOR=0
    let PATCH=0
    ;;
  minor)
    let MINOR+=1
    let PATCH=0
    ;;
  patch)
    let PATCH+=1
    ;;
esac

echo "$MAJOR.$MINOR.$PATCH"

NEW_VERSION=`echo "v${MAJOR}.${MINOR}.${PATCH}"`

git tag -fa v1 -m "Update v1 tag"
git push origin v1 --force

git tag -a ${NEW_VERSION} -m "release for ${NEW_VERSION}"
git push origin ${NEW_VERSION}
