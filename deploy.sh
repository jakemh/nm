#!/bin/bash

if $2 == true; then
  rake assets:precompile
fi 

git add .
git commit -m "$1"

cap production deploy