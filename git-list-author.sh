#!/bin/sh

git log | grep Author | sort | uniq
