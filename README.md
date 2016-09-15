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
	feature1 <- as.character(feature$V2) # to store as a list
	labels <- read.table("./activity_labels.txt", header = FALSE) #load labels.txt
	labels <- labels[,2] # store as a list
	labels <- as.character(labels) #to store list
   
Second Step: to change the variable name (Question 1)

	colnames(x_test) <- make.names(feature$V2,unique = TRUE) #make unique col name for x.test
	colnames(x_train) <- make.names(feature$V2,unique = TRUE) #make unique col name for x.train
	
	colnames(y_test) <- make.names(c("Activity"),unique = TRUE) #make unique col name for y.test
	colnames(y_train) <- make.names(c("Activity"),unique = TRUE) #make unique col name for y.train
    
Third Step: to merge x,y for both test and train (Question 1)

	train <- cbind(y_test,x_test) #combine y,x test
	test <- cbind(y_train,x_train) #combie y,x train
	    
	complete_yet <- rbind(train,test) #merge train and test data
    
Fourth Step: before we go to final cleanest data, we are going to look for the pattern of every single hearder in order to spot the correct column which require from the question  (Question 2)

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








