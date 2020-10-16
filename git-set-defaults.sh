# Little utility script to set sane default for a new clone I am working on.

#! /bin/sh
TRUE_FLAGS="commit.gpgSign tag.gpgSign"
FALSE_FLAGS="" # no false flag operations here

print_trues() {
  for F in ${TRUE_FLAGS} ; do
    echo -n "${F} => "; git config --get "${F}"
  done
}

echo "Before:"
print_trues

for F in ${TRUE_FLAGS} ; do
   git config --local "${F}" true
done

echo "After:"
print_trues
