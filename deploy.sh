# #!/bin/bash
git add .
git commit -m "$1"
git push origin angular

cap production deploy
git log --name-status HEAD^..HEAD | mail -s "test email" daniel.mcfarland@gmail.com
