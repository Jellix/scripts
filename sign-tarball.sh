#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
    echo "No or more than one tag given. Please provide exactly one."
    echo "Here's list:"
    git tag
    exit 1
fi

TAG="$1"
VERSION=$(echo -n "$1" | sed s/^v//)

# Temporarily create the tarball and sign it.
# Checkout the tag.
echo "Creating tarball and signing it..."

PROJECT=$(basename $(pwd))
TARBALL="${PROJECT}-${VERSION}.tar.gz"
SIGFILE="${TARFILE}.asc"

git archive --prefix="${VERSION}/" -o "${TARBALL}" "${TAG}"
gpg --armor --detach-sign "${TARBALL}"
sha512sum "${TARBALL}" > "${TARBALL}.sha512"
