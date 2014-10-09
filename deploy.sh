#!/bin/bash
git add .
git commit -m "$1"
git push server master

cap production deploy