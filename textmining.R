source("~/getFromDB/getFromDB.R")
require(plyr)
require(igraph)

wc <- readRDS("wc.RDS")
bigcomm <- names(table(wc$membership)[table(wc$membership) >= 50])
includedusers <- names(membership(wc)[wc$membership %in% bigcomm])

getUserInfo <- function(x) {
    return(getDB(paste0("select id, created_at, description, followers_count, friends_count, province from sinaweibo_users where id = ", x )))
}

ldply(includedusers[1:1000], getUserInfo, .progress = 'text')
