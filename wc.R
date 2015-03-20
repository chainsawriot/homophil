require(igraph)
weibo_graph <- readRDS("weibo_graph.RDS")
wc <- walktrap.community(weibo_graph)
saveRDS(wc, "wc.RDS")
