setwd("G:/Data/UCI HAR Dataset")
library(dplyr)

#############################################################################
x_test <- read.table("./test/X_test.txt", header = FALSE) #load x test.txt
y_test <- read.table("./test/y_test.txt", header = FALSE) #load y test.txt
subject_test <- read.table("./test/subject_test.txt", header = FALSE) #load subject test.txt

x_train <- read.table("./train/X_train.txt", header = FALSE) # load x train.txt
y_train <- read.table("./train/y_train.txt", header = FALSE) #load y train.txt
subject_train <- read.table("./train/subject_train.txt", header = FALSE) #load y subject train

feature <- read.table("./features.txt", header = FALSE) #load feature.txt
labels <- read.table("./activity_labels.txt", header = FALSE) #load labels.txt
labels1 <- labels[,2] 
labels1 <- as.character(labels1) #to store as a list for question 3


#Combine x,y and subject data#

subject <- rbind(subject_train,subject_test)  
activity <- rbind(y_train,y_test)
main <- rbind(x_train,x_test)

#Rename subject,activity and main data and combine all data'

colnames(subject) <- make.names(c("Subject"),unique = TRUE)
colnames(activity) <- make.names(c("Activity"),unique = TRUE)

names(main) <- feature$V2

complete <- cbind(subject,activity)
complete1 <- cbind(complete,main)

#Match all the feature and only taken sutiable keywords "mean()" and "std()" and tag back the activity to the sutiable class#

qu2 <- feature$V2[grep("std\\(\\)|mean\\(\\)",feature$V2)]

qu3 <- c(as.character(qu2),"Subject","Activity")
complete1<-subset(complete1,select = qu3)

complete1$Activity <- factor(complete1$Activity,levels = labels[,1], labels = labels[,2])

#Try to label escriptive variable names#

names(complete1)<-gsub("^t", "time", names(complete1))
names(complete1)<-gsub("^f", "frequency", names(complete1))

#gerenate final cleanest data!!!!!!#
final <- complete1 %>% group_by(Subject,Activity) %>% summarize_all(.,funs(mean))

write.table(final, "G:/Data/UCI HAR Dataset/final_baby_one_more_try.txt", row.name=FALSE)
