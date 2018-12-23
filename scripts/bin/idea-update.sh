#!/bin/bash

if [[ "$EUID" -ne "0" ]] ; then
    echo "Needs to be run as root. Try sudo."
    exit 1
fi

cd /home/alex/Downloads/

readonly IDEA_TAR=$(ls | grep idea | grep tar.gz | sort -r | head -n 1)
readonly TMP_DIR=/tmp/idea_tmp
readonly TMP_TARGET_DIR=$TMP_DIR/idea
readonly TARGET_DIR=/opt/idea

echo "Creating tmp dir: $TMP_DIR"
rm -r $TMP_DIR
mkdir $TMP_DIR

if [[ -z $IDEA_TAR ]] ; then 
    echo "There seems to be no idea*tar.gz in $(pwd)"
    exit 1
fi

echo "Unpacking $IDEA_TAR..."
tar -xzf $IDEA_TAR -C $TMP_DIR || { echo "Unpacking failed" ; exit 1; }
echo "Unpacked to $TMP_DIR"

readonly IDEA_ORIG_DIR=$(ls $TMP_DIR)
mv $TMP_DIR/$IDEA_ORIG_DIR $TMP_TARGET_DIR


echo "Clearing target directory: $TARGET_DIR"
rm -r $TARGET_DIR

echo "Moving idea to $TARGET_DIR..."
mv $TMP_TARGET_DIR $TARGET_DIR
echo "Update comleted"
