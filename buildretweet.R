source("~/getFromDB/getFromDB.R")
rt_links <- getDB("select created_at, user_id, retweeted_status_user_id from rp_sinaweibo where created_at >= '2015-01-01' and created_at < '2015-03-01'")
rt_links <- rt_links[!is.na(rt_links$retweeted_status_user_id),]

saveRDS(rt_links, "rt_links.rds")

# remove loops
rt_links <- rt_links[rt_links$user_id != rt_links$retweeted_status_user_id,]

#connect_tab <- as.data.frame(table(rt_links$user_id, rt_links$retweeted_status_user_id), stringsAsFactors = FALSE) ### didn't work!

## attack it by 'divide and conquer'

require(plyr)

## small scale testing

## testing <- rt_links[rt_links$retweeted_status_user_id %in% c(1248044160,1412348002),]

## ddply(testing, .(retweeted_status_user_id), function(x) as.data.frame(table(x$retweeted_status_user_id, x$user_id), stringsAsFactors = FALSE))

## seems to work!

connections <- ddply(rt_links, .(retweeted_status_user_id), function(x) as.data.frame(table(x$retweeted_status_user_id, x$user_id), stringsAsFactors = FALSE), .progress='text')



saveRDS(connections, "connections.RDS")
connections <- readRDS("connections.RDS")
require(igraph)

connections <- connections[,2:4]

## keep on edges with at least freq = 3
connections <- connections[connections$Freq > 2,]


weibo_graph <- graph.data.frame(connections[,1:2])
E(weibo_graph)$weight <- connections[,3]
saveRDS(weibo_graph, "weibo_graph.RDS")
#wc <- walktrap.community(weibo_graph)
#saveRDS(wc, "wc.RDS")
