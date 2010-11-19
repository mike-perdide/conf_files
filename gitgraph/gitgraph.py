#!/usr/bin/python
from git import Repo
import datetime

repo = Repo("/home/jmiotte/conf_files")
day = 32
month = 13
commits = 0
for commit in repo.iter_commits():
    commits += 1
    commit_date = datetime.datetime.fromtimestamp(commit.committed_date)
    if commit_date.day != day or month != commit_date.month:
        day = commit_date.day
        month = commit_date.month
        print day, "/", month, commits
        commits = 0
