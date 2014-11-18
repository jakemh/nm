# #!/bin/bash
git rev-parse head | xargs gh is $1 --comment
gh is $1 --close