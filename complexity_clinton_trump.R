###############
#Niels Goet
#31 Oct. 2016
###############

###############
#text complexity
###############
setwd("~/Documents/Oxford/DPhil/Teaching/Political Analysis Using R/2016:2017/blog_posts")

speeches <- read.csv("speeches.csv",header=T,stringsAsFactors=T,encoding="UTF-8")
speeches$speech <- as.character(speeches$speech)

library(quanteda)

scores <- data.frame(readability(speeches$speech,measure=c("Flesch.Kincaid","Dale.Chall.old")))

speeches$Flesch.Kincaid <- scores$Flesch.Kincaid

speeches$Dale.Chall.old <- scores$Dale.Chall.old


###############
#plots
###############
library(ggplot2)
#############################
#Figure 1: Sentiment analysis
#############################
sentiment_data <- read.csv("sent_analysis.csv",header=T)
sentiment_data$ind <- seq(1,nrow(sentiment_data),1)

png("sent_analysis.png", width = 8, height = 5, units = 'in', res = 300)

ggplot(data=sentiment_data,aes(x=date.ind,y=score,fill=speaker)) + 
  geom_bar(aes(fill=speaker,width=.8), stat="identity", position="identity",alpha=.6) + 
  ggtitle("Sentiment in candidate speeches") + 
  labs(x="Dates",y="Sentiment score") + 
  scale_color_manual(values=c("blue", "red")) +
  scale_x_continuous(breaks=seq(min(unique(speeches$date.ind)),max(unique(speeches$date.ind)),7),labels = speeches$date[seq(min(unique(speeches$date.ind)),max(unique(speeches$date.ind)),7)]) +
  scale_fill_manual(values=c("dodgerblue2", "red3"))

dev.off()

#################################
#Figures 2-3: Text complexity scores
#################################
#Fig. 2: Complexity measure 1 (Flesch-Kincaid)
png("flesch-kincaid.png", width = 8, height = 5, units = 'in', res = 300)

ggplot(data=speeches,aes(x=date.ind,y=Flesch.Kincaid,fill=speaker)) + 
  geom_bar(aes(fill=speaker,width=.8), stat="identity", position="identity",alpha=.6) + 
  ggtitle("Flesch-Kincaid score") + 
  labs(x="Dates") + 
  scale_color_manual(values=c("blue", "red")) +
  scale_x_continuous(breaks=seq(min(unique(speeches$date.ind)),max(unique(speeches$date.ind)),7),labels = speeches$date[seq(min(unique(speeches$date.ind)),max(unique(speeches$date.ind)),7)]) +
  scale_fill_manual(values=c("dodgerblue2", "red3"))

dev.off()

#Fig. 3: Complexity measure 2 (Dale-Chall)
png("dale_chall.png", width = 8, height = 5, units = 'in', res = 300)

ggplot(data=speeches,aes(x=date.ind,y=Dale.Chall.old,fill=speaker)) + 
  geom_bar(aes(fill=speaker,width=.8), stat="identity", position="identity",alpha=.6) + 
  ggtitle("Dale-Chall index") + 
  labs(x="Dates") + 
  scale_color_manual(values=c("blue", "red")) +
  scale_x_continuous(breaks=seq(min(unique(speeches$date.ind)),max(unique(speeches$date.ind)),7),labels = speeches$date[seq(min(unique(speeches$date.ind)),max(unique(speeches$date.ind)),7)]) +
  scale_fill_manual(values=c("dodgerblue2", "red3")) 

dev.off()
