#!/usr/bin/python
from git import Repo
import datetime

repo = Repo(".")
current_day = 0
current_month = 0
current_year = 0
commits = {}

summup = {}

markers = ["#", "*", "-", "+", "="]

authors_marker_mapping = {}

for commit in repo.iter_commits():
    author = str(commit.author)

    if not authors_marker_mapping.has_key(author):
        marker = markers.pop()
        authors_marker_mapping[author] = marker

    commit_date = datetime.datetime.fromtimestamp(commit.committed_date)
    new_day = commit_date.day
    new_month = commit_date.month
    new_year = commit_date.year

    if new_year != current_year:
        current_year = new_year
        summup[current_year]= {}

    if new_month != current_month:
        current_month = new_month
        summup[current_year][current_month] = {}

    if commit_date.day != current_day:
        current_day = new_day
        summup[current_year][current_month][current_day] = {}

    commits = summup[current_year][current_month][current_day]
    if not commits.has_key(author):
        commits[author] = 1
    else:
        commits[author] += 1
for year in summup:
    for month in summup[year]:
        for day in summup[year][month]:
            s_day = "0%d" % day if day <10 else "%d" % day
            s_month = "0%d" % month if month <10 else "%d" % month
            full_line = "%s/%s/%d" % (s_day, s_month, year) + " "
            for author in summup[year][month][day]:
                n_commits = summup[year][month][day][author]
                full_line += authors_marker_mapping[author] * n_commits
            print full_line

print "====== Legend : ======"
for author in authors_marker_mapping:
    print author, authors_marker_mapping[author]
