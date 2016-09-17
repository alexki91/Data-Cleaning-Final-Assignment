# Data-Cleaning-Final-Assignment

My name is Alex and welcome to come here and rate my project, thank you.

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




	
Match all the feature and only taken sutiable keywords "mean()" and "std()" and tag back the activity to the sutiable clas
	    
	    
Fourth Step: Match all the feature and only taken sutiable keywords "mean()" and "std()" and tag back the activity to the sutiable clas

	abc <- grep(pattern = "[aA][Mm][Ee][Nn]|[Tt][Dd][Ss]", x = names(complete_yet)) #pull a list of of the elements pattern
	sub <-complete_yet[,abc]
	sub1 <-grep(pattern = "gravityMean|tBodyAccMean|meanFreq", x = names(sub))
	
	sub <- select(sub, -c(sub1)) # to gerante the clean data

Fifth Step: to match the numbers and the activity desciprtiosn then replace the numbers to the descirption (Question 3)

	def = 1
	while (def <= length(labels1)){complete_yet$Activity[complete_yet$Activity == def] <- labels1[def]; def = def + 1 }
	
Sixth Step: to tag back feature and activity (Question 4)

	complete_yet <- setNames(complete_yet,c("Activity",feature1))

Final Step: (Question 5)

	final <- complete_yet %>% group_by(Activity) %>% summarize_all(.,funs(mean)) # to make sumamry table of each varaibles by activity label

Then write it out: (Question 5)

	write.table(final, "G:/Data/UCI HAR Dataset/final_baby.txt", sep="\t") # :)








