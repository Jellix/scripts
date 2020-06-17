#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
   echo "No or more than one tag given. Please provide exactly one."
   echo "Here's a list:"
   (echo "TAG|DATE" && git tag --sort="creatordate" --format="%(refname:short)|%(authordate:iso8601)") | column -s\| -t -x
   exit 1
fi

if [[ "$1" = "-h" || "$1" = "--help" ]]; then
   echo "Creates a tarball for the specified tag and signs it.

  Usage:
    $(basename "$0") <tag-name>

    Should be run from inside the root of a git repository.

    <tag-name> is expected to be in the format v<some-version-number>. The
    leading 'v' will be stripped from the <tag-name> for further operations,
    this part is referred to as version number in the text below.

  Naming:
    The tarball will be named after the last part of your current directory
    (which is preferrably the project's name), and the version number extracted
    from the tag.
    The contents inside the tarball will be the git archive with the version
    number prepended as path.

  Output:
    The tarball, resulting signature file (<tarball>.asc) and SHA-512 checksum
    file (<tarball>.sha512) will be put into the current directory.

  And that's about all the help you get from me.
"
   exit 0
fi

TAG="$1"
VERSION=$(echo -n "$1" | sed s/^v//)

# Create the tarball and sign it.
echo "Creating tarball and signing it..."

PROJECT=$(basename $(pwd))
TARBALL="${PROJECT}-${VERSION}.tar.gz"
SIGFILE="${TARFILE}.asc"

git archive --prefix="${VERSION}/" -o "${TARBALL}" "${TAG}"
gpg --armor --detach-sign "${TARBALL}"
sha512sum "${TARBALL}" > "${TARBALL}.sha512"
