# 1.Merges the training and the test sets to create one data set.
tmp1<-read.table("./train/X_train.txt")
tmp2<-read.table("./test/X_test.txt")
x<-rbind(tmp1,tmp2)
tmp1<-read.table("./train/y_train.txt")
tmp2<-read.table("./test/y_test.txt")
y<-rbind(tmp1,tmp2)
tmp1<-read.table("./train/subject_train.txt")
tmp2<-read.table("./test/subject_test.txt")
subject<-rbind(tmp1,tmp2)

#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
features<-read.table("./features.txt")
data2<-grep(pattern = ".*-mean\\(\\).*|.*-std\\(\\).*",x = features[,2])
x<-x[,data2]
names(x)<-features[data2,2]

#3.Uses descriptive activity names to name the activities in the data set
activity<-read.table("./activity_labels.txt")
y[,1]=activity[y[,1],2]

#4.Appropriately labels the data set with descriptive variable names. 
combineddata<-cbind(subject,y,x)
colnames(combineddata)[1]<-"subject_id"
colnames(combineddata)[2]<-"activity_label"

#5.From the data set in step 4, creates a second, independent tidy data set with the average
#of each variable for each activity and each subject.
attach(combineddata)
data5<-aggregate(subset(combineddata,select = -c(subject_id,activity_label)),by = list(subject_id,activity_label),mean)
colnames(data5)[1]<-"subject_id"
colnames(data5)[2]<-"activity_label"
getwd()
write.table(x = data5,file="step5.txt",row.names=FALSE,quote=FALSE)
