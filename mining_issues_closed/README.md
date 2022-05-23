# Extracting closed issues data from GitHub using GitHub Issues API 

 - Add your GitHub username and token in the beginning of the file *fetchScript_issues_closed_title.sh*.
 - Modify the list of repositories in the file *apiLinks_issues* (depending on the repositories of interest).
 - Run *bash loop_theFetchScript_issues_closed.sh* to fetch data from all specified repositories.
 - As a result a csv file with the id, state (open/closed), creation date, closing date and title of all closed issues would be created.
