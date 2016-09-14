# Data-Cleaning-Final-Assignment
The code is at below
#####Please set your dicetory into something like this ---> G:\Data\UCI HAR Dataset#####

1. x_test <- read.table("./test/X_test.txt", header = FALSE) #load x test.txt
   y_test <- read.table("./test/y_test.txt", header = FALSE) #load y test.txt
   subject_test <- read.table("./test/subject_test.txt", header = FALSE) #load subject test.txt

   x_train <- read.table("./train/X_train.txt", header = FALSE) # load x train.txt
   y_train <- read.table("./train/y_train.txt", header = FALSE) #load y train.txt
   subject_train <- read.table("./train/subject_train.txt", header = FALSE) #load y subject train

2. feature <- read.table("./features.txt", header = FALSE) #load feature.txt
   labels <- read.table("./activity_labels.txt", header = FALSE) #load labels.txt

   y_full_test<-merge(y_test,labels) #tag the label with y.txt
   y_full_train<-merge(y_train,labels) #tag the label with y.txt

3. colnames(y_full_test) <- make.names(c("1","Y"),unique = TRUE) #make unique col name for y.test
   colnames(y_full_train) <- make.names(c("1","Y"),unique = TRUE) #make unique col name for y.train

   colnames(x_test) <- make.names(feature$V2,unique = TRUE) #make unique col name for x.test
   colnames(x_train) <- make.names(feature$V2,unique = TRUE) #make unique col name for x.train

4. subject <- rbind(subject_test,subject_train) #combine subject for train and test
   y_full<- rbind(y_full_test,y_full_train)  #combine y.txt for train and test
   data<-rbind(x_test,x_train)  #combine x.txt for train and test

   colnames(subject) <- make.names(c("Subject"),unique = TRUE) #make unique col name for subject

   complete<-cbind(subject,y_full,data) #finally a full clean data set 

5. qu2<- complete[grep("mean|std|Subject|Activity", names(complete))] # to extract all the mean() and std()

6. library(dplyr) # apply library dplyr package

7. final <- qu2 %>% group_by(Subject,Activity) %>% summarize_all(.,funs(mean)) # work out all the average by subject and activity
