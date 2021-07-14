# Question 1: 
# Register an application with the Github API here https://github.com/settings/applications. 
# Access the API to get information on your instructors repositories (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). 
# Use this data to find the time that the datasharing repo was created. What time was it created?
# This tutorial may be useful (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). 
# You may also need to run the code in the base R package and not R studio.

library(httr)
library(jsonlite)

myapp <- oauth_app(appname = "coursera_github",
                   key = "5f8d939f8ae1df9d2b48",
                   secret = "63034c5677bef26175ca9868ee5e3b0e1d4bb44b")


github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)

# Extract content from a request
json1 = content(req)

# Convert to a data.frame
json2 = jsonlite::fromJSON(toJSON(json1))

# Subset data.frame
json2[json2$full_name == "jtleek/datasharing", "created_at"]
