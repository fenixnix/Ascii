import os
os.system("git checkout --orphan latest_branch")
os.system("git add -A")
os.system("git commit -am 'reori'")
os.system("git branch -D master")
os.system("git branch -m master")
os.system("git push -f origin master")
