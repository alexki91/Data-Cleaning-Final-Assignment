# Data-Cleaning-Final-Assignment

My name is Alex and welcome to come here and rate my project, thank you.

The requirement and main onjectives of this project:

	1. Merges the training and the test sets to create one data set.
	2. Extracts only the measurements on the mean and standard deviation for each measurement.
	3. Uses descriptive activity names to name the activities in the data set
	4. Appropriately labels the data set with descriptive variable names.
	5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each 		   activity and each subject.
	
To satisfy all the requirements from above, we need to process the R.script below in order to gerenate the cleanest data and it calls "final_baby_one_more_try"

###############################
	setwd("G:/Data/UCI HAR Dataset")
	library(dplyr)
###############################

First Step: to read all the essential tables (Question 1)

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
   
Second Step: combine all the data

	subject <- rbind(subject_train,subject_test)  
	activity <- rbind(y_train,y_test)
	main <- rbind(x_train,x_test)
    
Third Step: Rename subject,activity and main data and combine all data'

	colnames(subject) <- make.names(c("Subject"),unique = TRUE)
	colnames(activity) <- make.names(c("Activity"),unique = TRUE)
	
	names(main) <- feature$V2
	
	complete <- cbind(subject,activity)
	complete1 <- cbind(complete,main)

Fourth Step: Match all the feature and only taken sutiable keywords "mean()" and "std()" and tag back the activity to the sutiable class

	qu2 <- feature$V2[grep("std\\(\\)|mean\\(\\)",feature$V2)]
	
	qu3 <- c(as.character(qu2),"Subject","Activity")
	complete1<-subset(complete1,select = qu3)
	
	complete1$Activity <- factor(complete1$Activity,levels = labels[,1], labels = labels[,2])
	
Final Step:

	#Try to label escriptive variable names#
	
	names(complete1)<-gsub("^t", "time", names(complete1))
	names(complete1)<-gsub("^f", "frequency", names(complete1))
	
	#gerenate final cleanest data!!!!!!#
	
	final <- complete1 %>% group_by(Subject,Activity) %>% summarize_all(.,funs(mean))
	
	write.table(final, "G:/Data/UCI HAR Dataset/final_baby_one_more_try.txt", row.name=FALSE)








