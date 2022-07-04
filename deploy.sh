#!/bin/sh

set -e

if [ -d book-output ] ; then
    if [ "$1" == "force" ] ; then
        echo "Removing leftover book-output/ directory"
        rm -rf book-output/
    else
        echo "book-output/ exists and force flag not provided."
        echo "Re-run as './_deploy.sh force' or first call 'rm -rf book-output'"
        exit 1
    fi
fi

git clone -b gh-pages `git config --get remote.origin.url` book-output
cd book-output
cp -r ../_book/* ./
git add --all *
git commit -m "Update the book" || true
git push -q origin gh-pages
