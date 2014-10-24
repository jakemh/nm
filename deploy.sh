#!/bin/bash
git add .
git commit -m "$1"
git push server angular

cap production deploy