
library(reshape2)

# helper function to read the files
read_file <- function(f_name) {
    read.table(f_name,
               header=FALSE,
               sep="")
}

# function to read files and combine data into one dataframe
read_and_combine_data <- function() {

    print("reading meta data")
    activities <- read_file("data/activity_labels.txt")
    features <- read_file("data/features.txt")
    
    print("reading training data")
    train_activities <- read_file("data/train/y_train.txt")
    train_subjects <- read_file("data/train/subject_train.txt")
    train_data <- read_file("data/train/x_train.txt")
    
    print("reading test data")
    test_activities <- read_file("data/test/y_test.txt")
    test_subjects <- read_file("data/test/subject_test.txt")
    test_data <- read_file("data/test/x_test.txt")
    
    print("combing test and training data")
    all_activities <- rbind(train_activities, test_activities)
    all_subjects <- rbind(train_subjects, test_subjects)
    all_data <- rbind(train_data, test_data)
    
    print("naming columns")
    names(all_data) <- features[,2]
    
    print("adding activity and subject columns to main data set")
    all_data$activityid <- all_activities
    all_data$subject <- all_subjects
    
    print("adding activity description")
    names(activities) <- c("activityid", "activity")
    
    DF <- as.data.frame(lapply(all_data, function(X) unname(unlist(X))))
    all_data <- merge(DF, activities,"activityid")
    
    print("returning all data")
    all_data
}


reshape_data <- function(all_data) {
    print("selecting columns that contain mean or standard deviation data")
    selected <- names(all_data)[grep("mean|std", names(all_data))]
    
    print("'melting' data to long form with variables containing all the select variables")
    long_form <- melt(all_data, id=c("subject", "activity"), measure.vars=selected)
    
    print("reshaping data to wide form calculating the mean of each variable grouped by subject and activity")
    wide_mean <- dcast(long_form, subject + activity ~ variable,mean)
    
    print("returning data in wide form")
    wide_mean
    
}

# putting it all together
process_data <- function(){
    all_data <- read_and_combine_data()
    result <- reshape_data(all_data)
    print("writing result to file result.txt")
    write.table(result,"result.txt", row.name=FALSE)
}

