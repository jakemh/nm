# #!/bin/bash
git rev-parse head | xargs git is $1 
git is $1 --close