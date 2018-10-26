#   Load httr and httpuv packages
library("httr")
library("httpuv")
#   1. Find OAuth settings for github: http://developer.github.com/v3/oauth/
oauth_endpoints("github")
#   2. Register an application at https://github.com/settings/applications;
#      Use any URL you would like for the homepage URL (http://github.com is fine)
#      and http://localhost:1410 as the callback url
#
#      Insert your client ID and secret below - if secret is omitted, it will
#      look it up in the GITHUB_CONSUMER_SECRET environmental variable.
myapp <- oauth_app("github",key = "your_key",secret = "your_secret")
gtoken <- config(token = github_token)

req <- GET("https://api.github.com/rate_limit", gtoken)

stop_for_status(req)

content(req)
