#!/usr/bin/env python
from git import Repo
from datetime import datetime

repo = Repo(".")
current_day = 0
current_month = 0
current_year = 0
commits = {}

summup = {}

markers = ["#", "*", "/", "$", "=", "-", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q"]

authors_marker_mapping = {}

for commit in repo.iter_commits():
    author = str(commit.author)

    if not authors_marker_mapping.has_key(author):
        marker = markers.pop()
        authors_marker_mapping[author] = marker

    commit_date = datetime.fromtimestamp(commit.authored_date)
    new_day = commit_date.day
    new_month = commit_date.month
    new_year = commit_date.year

    if not summup.has_key(new_year):
        summup[new_year] = {}

    if not summup[new_year].has_key(new_month):
        summup[new_year][new_month] = {}

    if not summup[new_year][new_month].has_key(new_day):
        summup[new_year][new_month][new_day] = {}

    commits = summup[new_year][new_month][new_day]
    if not commits.has_key(author):
        commits[author] = 1
    else:
        commits[author] += 1

#    print new_day, new_month, new_year, commit.message.strip().split("\n")[0]


years_ordered = summup.keys()
years_ordered.sort()
print years_ordered
for year in years_ordered:
    months_ordered = summup[year].keys()
    months_ordered.sort()
    for month in months_ordered:
        days_ordered = summup[year][month].keys()
        days_ordered.sort()
        for day in days_ordered:
            s_day = "0%d" % day if day <10 else "%d" % day
            s_month = "0%d" % month if month <10 else "%d" % month
            full_line = "%s/%s/%d" % (s_day, s_month, year) + " "
            total = 0
            for author in summup[year][month][day]:
                n_commits = summup[year][month][day][author]
                full_line += authors_marker_mapping[author] * n_commits
                total += n_commits
            print full_line, total
        print ""

print "====== Legend : ======"
for author in authors_marker_mapping:
    print author, authors_marker_mapping[author]
