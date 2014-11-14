#!/bin/bash
git add .
git commit -m "$1"
git push origin angular

cap production deploy
echo "deploy completed" | mail -s "deploy completed\!" jakemh@gmail.com
